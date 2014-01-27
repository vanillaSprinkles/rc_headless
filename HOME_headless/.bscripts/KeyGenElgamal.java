package org.halfdog.crypttools.pgp;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import java.math.BigInteger;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class KeyGenElgamal {

  private String	uidString;
  private SecureRandom	random;

  public static void main(String args[]) {
    if(args.length!=2) {
      System.err.println("Usage: KeyGen [privkey] [uid]\n  Private key file has to be password-less");
      System.exit(1);
    }
    try {
      FileInputStream fin=new FileInputStream(args[0]);
      byte data[]=new byte[fin.available()];
      fin.read(data);
      fin.close();

      new KeyGenElgamal(data, args[1]);
    } catch (Throwable t) {
      t.printStackTrace();
      System.exit(1);
    }
  }


  public KeyGenElgamal(byte privkeyData[], String uidString) {
    this.uidString=uidString;

    BigInteger p=new BigInteger("xx", 16);
    BigInteger g=new BigInteger("xx", 16);
    BigInteger x=new BigInteger("xx", 16);

// Start looping across fingerprints
    ByteBuffer pubkeyBuffer=ByteBuffer.allocate(1<<16).
        order(ByteOrder.BIG_ENDIAN);
    buildPubkeyPacket(pubkeyBuffer, p, g, x);
    int dateRange=3000000;
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
//        System.out.println(Integer.toHexString(ival));
      if((ival&0xfffffff)==0xeedabee) {
        System.out.println("Hit at 0x"+new BigInteger(1, digest).toString(16)+" xval="+x.toString(16));
        buildPrivateKeyFile(pubkeyData, pubkeyLength, p, g, x);
      }
      int pos=7;
      while((pubkeyData[pos--]--)==0) {
        if(pos==3) break;
      }
      dateRange--;
      if(dateRange==0) {
        x=x.add(BigInteger.ONE);
        pubkeyBuffer.position(0);
        buildPubkeyPacket(pubkeyBuffer, p, g, x);
        dateRange=300000;
      }
    }
  }


/** Build public key packet only. Uid and self-signature packet
 *  has to be appended if standard full public key file is needed.
 */
  private void buildPubkeyPacket(ByteBuffer buffer, BigInteger p,
      BigInteger g, BigInteger x) {
    buffer.put((byte)0x99).position(3);
    buffer.put((byte)4).
        putInt((int)(System.currentTimeMillis()/1000)-50000).
        put((byte)0x10);

    putInteger(buffer, p);
    putInteger(buffer, g);
    putInteger(buffer, g.modPow(x, p));

    buffer.putShort(1, (short)(buffer.position()-3));
  }



/** Build the private key file data including private key, uid and
 *  selfsignature packet.
 */
  private void buildPrivateKeyFile(byte pubkeyData[], int pubkeyLength,
      BigInteger p, BigInteger g, BigInteger x) {
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
