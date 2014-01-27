package org.halfdog.crypttools.pgp;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import java.math.BigInteger;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

/** Generate a DSA key with nice fingerprint. The program a few
 *  known problems (incomplete list): uid/policy string length
 *  handling error for long strings, no negative x checks. The
 *  program does not have command line options for each setting,
 *  search for FIXMEs and adjust these values in the code.
 *
 *  Author: halfdog me(%)halfdog.net
 *  Version: V0.1 20100510
 */
public class KeyGenDSA {

  private byte		uidData[];
/** This field contains the policy url information to be included
 *  in the signature.
 *  FIXME: Add your policy url information here.
 */
  private byte		policyUrlData[]=
      "http://www.somehost.org/PgpPolicy.html".getBytes();
  private SecureRandom	random;

  public static void main(String args[]) {
    if(args.length!=2) {
      System.err.println("Usage: KeyGenDSA [privkey] [uid]\n  Private key file has to be password-less");
      System.exit(1);
    }
    try {
      FileInputStream fin=new FileInputStream(args[0]);
      byte data[]=new byte[fin.available()];
      fin.read(data);
      fin.close();

      new KeyGenDSA(data, args[1]);
    } catch (Throwable t) {
      t.printStackTrace();
      System.exit(1);
    }
  }


  public KeyGenDSA(byte privkeyData[], String uidStr) {
    this.uidData=uidStr.getBytes();

    ByteBuffer buffer=ByteBuffer.wrap(privkeyData).order(ByteOrder.BIG_ENDIAN);
    if(buffer.get()!=(byte)0x95)
      throw new IllegalArgumentException("Input data not private key block");
    buffer.position(buffer.position()+7);
    if(buffer.get()!=0x11)
      throw new IllegalArgumentException("Only DSA supported");
    BigInteger p=readInteger(buffer);
    BigInteger q=readInteger(buffer);
    BigInteger g=readInteger(buffer);
    readInteger(buffer); // Ignore y
    if(buffer.get()!=0)
       throw new IllegalArgumentException("Only unencrypted private supported");
    BigInteger x=readInteger(buffer);

// Start looping across fingerprints
    ByteBuffer pubkeyBuffer=ByteBuffer.allocate(1<<16).
        order(ByteOrder.BIG_ENDIAN);
    buildPubkeyPacket(pubkeyBuffer, p, q, g, x);
    byte pubkeyData[]=pubkeyBuffer.array();
    int pubkeyLength=pubkeyBuffer.position();

    MessageDigest digestAlgo=null;
    try {
      digestAlgo=MessageDigest.getInstance("SHA1");
    } catch (NoSuchAlgorithmException nsae) {
      throw new InternalError("No security extensions");
    }
    try {
      random=SecureRandom.getInstance("SHA1PRNG");
    } catch (NoSuchAlgorithmException nsae) {
      throw new InternalError("No security extensions");
    }
    random.setSeed(pubkeyData);
    random.setSeed(privkeyData);

    while(true) {
      digestAlgo.reset();
      digestAlgo.update(pubkeyData, 0, pubkeyLength);
      byte digest[]=digestAlgo.digest();
      int ival=((digest[16]&0xff)<<24)|((digest[17]&0xff)<<16)|
          ((digest[18]&0xff)<<8)|(digest[19]&0xff);
// FIXME: Your condition here
      if((ival==0xabaddeed)||((ival&0xffff)==0xabcd)) {
        System.out.println("Hit at 0x"+new BigInteger(1, digest).toString(16)+" xval="+x.toString(16));
        buildPrivateKeyFile(pubkeyData, pubkeyLength, p, q, g, x);
      }
      int pos=7;
      while((pubkeyData[pos--]--)==0) {
        if(pos==5) {
          x=x.subtract(BigInteger.ONE);
          pubkeyBuffer.position(0);
          buildPubkeyPacket(pubkeyBuffer, p, q, g, x);
          break;
        }
      }
    }
  }


/** Build public key packet only. Uid and self-signature packet
 *  has to be appended if standard full public key file is needed.
 */
  private void buildPubkeyPacket(ByteBuffer buffer, BigInteger p,
      BigInteger q, BigInteger g, BigInteger x) {
    buffer.put((byte)0x99).position(3);
    buffer.put((byte)4).
        putInt((int)(System.currentTimeMillis()/1000)).
        put((byte)0x11);

    putInteger(buffer, p);
    putInteger(buffer, q);
    putInteger(buffer, g);
    putInteger(buffer, g.modPow(x, p));

    buffer.putShort(1, (short)(buffer.position()-3));
  }



/** Build the private key file data including private key, uid and
 *  selfsignature packet.
 */
  private void buildPrivateKeyFile(byte pubkeyData[], int pubkeyLength,
      BigInteger p, BigInteger q, BigInteger g, BigInteger x) {

    MessageDigest digestAlgo=null;
    try {
      digestAlgo=MessageDigest.getInstance("SHA1");
    } catch (NoSuchAlgorithmException nsae) {
      throw new InternalError("No security extensions");
    }
    digestAlgo.update(pubkeyData, 0, pubkeyLength);
    byte pubKeyHash[]=digestAlgo.digest();

    ByteBuffer buffer=ByteBuffer.allocate(1<<16).order(ByteOrder.BIG_ENDIAN);
    buffer.put((byte)0x95).position(3);
    buffer.put(pubkeyData, 3, pubkeyLength-3);
    buffer.put((byte)0); // Private key encryption mode
    putInteger(buffer, x);
    int csVal=(x.bitLength()&0xff)+((x.bitLength()>>8)&0xff);
    byte xdata[]=x.toByteArray();
    for(int pos=xdata.length-1; pos>=0; pos--) csVal+=(xdata[pos]&0xff);
    buffer.putShort((short)csVal);
    buffer.putShort(1, (short)(buffer.position()-3));

    buffer.put((byte)0xb4);
    buffer.put((byte)uidData.length);
    buffer.put(uidData);

    int signatureStart=buffer.position();
    buffer.put((byte)0x88);
    buffer.put((byte)0);
    int signatureHashDataStart=buffer.position();
    buffer.put(new byte[]{4, 0x13, 0x11, 2, 0, 0, 5, 2}).
        put(pubkeyData, 4, 4).
        put(new BigInteger("021b03050909660180060b090807030204150208030416020301021e01021780", 16).toByteArray());
    if(policyUrlData!=null) {
      buffer.put((byte)(policyUrlData.length+1)).
          put((byte)0x1a).put(policyUrlData);
    }
    int signatureHashDataEnd=buffer.position();
    buffer.putShort(signatureHashDataStart+4,
        (short)(signatureHashDataEnd-signatureHashDataStart-6));

// Signature data for self signature
    digestAlgo.reset();
    digestAlgo.update(pubkeyData, 0, pubkeyLength);
// Put uid with 4-byte length
    digestAlgo.update(new byte[]{(byte)0xb4, 0, 0, 0});
    digestAlgo.update((byte)uidData.length);
    digestAlgo.update(uidData);
    digestAlgo.update(buffer.array(), signatureHashDataStart,
        signatureHashDataEnd-signatureHashDataStart);
    digestAlgo.update(new byte[]{4, (byte)0xff, 0, 0, 0,
        (byte)(signatureHashDataEnd-signatureHashDataStart)});
    byte signatureHash[]=digestAlgo.digest();

    buffer.putShort((short)0xa); // Unhashed data
    buffer.putShort((short)0x910);
    buffer.put(pubKeyHash, pubKeyHash.length-8, 8);
    buffer.put(signatureHash, 0, 2);

    random.setSeed(pubkeyData);
    random.setSeed(buffer.array());
    BigInteger k=new BigInteger(q.bitLength()+50, random).mod(q);
    BigInteger r=g.modPow(k, p).mod(q);
    BigInteger s=x.multiply(r).add(new BigInteger(1, signatureHash)).
        multiply(k.modInverse(q)).mod(q);
    putInteger(buffer, r);
    putInteger(buffer, s);
    buffer.put(signatureStart+1, (byte)(buffer.position()-signatureStart-2));

    byte data[]=new byte[buffer.position()];
    buffer.position(0);
    buffer.get(data);
    System.out.println("Privkey: "+new BigInteger(1, data).toString(16));
  }


  private void putInteger(ByteBuffer buffer, BigInteger val) {
    byte data[]=val.toByteArray();
    if((val.bitLength()&7)==0) {
      buffer.putShort((short)val.bitLength()).put(data, 1, data.length-1);
    } else {
      buffer.putShort((short)val.bitLength()).put(data);
    }
  }

  private BigInteger readInteger(ByteBuffer buffer) {
    int length=buffer.getShort()&0xffff;
    byte data[]=new byte[(length+7)>>3];
    buffer.get(data);
    return(new BigInteger(1, data));
  }
}
