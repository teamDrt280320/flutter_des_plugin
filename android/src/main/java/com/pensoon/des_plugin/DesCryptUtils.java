package com.pensoon.des_plugin;

import android.util.Base64;
import java.security.Key;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;

/**
 * des加解密工具类
 */
public class DesCryptUtils {
    public static final String ALGORITHM_DES = "desede/CBC/PKCS5Padding";
    /**
     * @param sourceBytes 要加密的字符串
     * @param mode        加密模式 加密：Cipher.ENCRYPT_MODE 解密：Cipher.DECRYPT_MODE
     * @param desKey
     * @return
     * @Comments ：对字符串进行加密
     */
    public static byte[] crypt(byte[] sourceBytes, int mode, String desKey) throws Exception {
        SecureRandom sr = new SecureRandom();
        DESKeySpec dks = new DESKeySpec(desKey.getBytes());
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey securekey = keyFactory.generateSecret(dks);
        Cipher cipher = Cipher.getInstance("DES/ECB/PKCS5Padding");
        cipher.init(mode, securekey, sr);
        return cipher.doFinal(sourceBytes);
    }

    public static String decrypt(String key , String data) throws Exception {
        byte[] target = crypt(Base64.decode(data , Base64.DEFAULT) , Cipher.DECRYPT_MODE , key);
        return new String(target);
    }

    /**
     * 加密数据
     * @param jsonData
     * @return
     */
    public static String encrypt(String key , String jsonData) throws Exception {
        byte[] target = crypt(jsonData.getBytes() , Cipher.ENCRYPT_MODE , key);
        return new String(Base64.encode(target , Base64.DEFAULT));
    }

    /**
     * 3des解密
     * @param key 解密私钥，长度不能够小于8位
     * @param data 待解密字符串
     * @return 解密后的字节数组
     */
    public static String decode(String key, String data, String ivSpec) throws Exception {
        DESedeKeySpec spec = new DESedeKeySpec(key.getBytes());
        SecretKeyFactory keyfactory = SecretKeyFactory.getInstance("desede");
        Key deskey = keyfactory.generateSecret(spec);

        Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
        IvParameterSpec ips = new IvParameterSpec(ivSpec.getBytes());
        cipher.init(Cipher.DECRYPT_MODE, deskey, ips);

        byte[] bOut = cipher.doFinal(Base64.decode(data  , Base64.DEFAULT));
        return new String(bOut);
    }
}
