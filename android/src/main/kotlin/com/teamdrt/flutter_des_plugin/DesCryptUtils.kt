package com.teamdrt.flutter_des_plugin

import android.util.Base64
import java.security.Key
import java.security.SecureRandom
import javax.crypto.Cipher
import javax.crypto.SecretKeyFactory
import javax.crypto.spec.DESKeySpec
import javax.crypto.spec.DESedeKeySpec
import javax.crypto.spec.IvParameterSpec

/**
 * des加解密工具类
 */
object DesCryptUtils {
    const val ALGORITHM_DES = "desede/CBC/PKCS5Padding"

    /**
     * @param sourceBytes 要加密的字符串
     * @param mode        加密模式 加密：Cipher.ENCRYPT_MODE 解密：Cipher.DECRYPT_MODE
     * @param desKey
     * @return
     * @Comments ：对字符串进行加密
     */
    @Throws(Exception::class)
    fun crypt(sourceBytes: ByteArray?, mode: Int, desKey: String): ByteArray {
        val sr = SecureRandom()
        val dks = DESKeySpec(desKey.toByteArray())
        val keyFactory = SecretKeyFactory.getInstance("DES")
        val securekey = keyFactory.generateSecret(dks)
        val cipher = Cipher.getInstance("DES/ECB/PKCS5Padding")
        cipher.init(mode, securekey, sr)
        return cipher.doFinal(sourceBytes)
    }

    @Throws(Exception::class)
    fun decrypt(key: String, data: String?): String {
        val target = crypt(Base64.decode(data, Base64.DEFAULT), Cipher.DECRYPT_MODE, key)
        return String(target)
    }

    /**
     * 加密数据
     * @param jsonData
     * @return
     */
    @Throws(Exception::class)
    fun encrypt(key: String, jsonData: String): String {
        val target = crypt(jsonData.toByteArray(), Cipher.ENCRYPT_MODE, key)
        return String(Base64.encode(target, Base64.DEFAULT))
    }

    /**
     * 3des解密
     * @param key 解密私钥，长度不能够小于8位
     * @param data 待解密字符串
     * @return 解密后的字节数组
     */
    @Throws(Exception::class)
    fun decode(key: String, data: String?, ivSpec: String): String {
        val spec = DESedeKeySpec(key.toByteArray())
        val keyfactory = SecretKeyFactory.getInstance("desede")
        val deskey: Key = keyfactory.generateSecret(spec)
        val cipher = Cipher.getInstance(ALGORITHM_DES)
        val ips = IvParameterSpec(ivSpec.toByteArray())
        cipher.init(Cipher.DECRYPT_MODE, deskey, ips)
        val bOut = cipher.doFinal(Base64.decode(data, Base64.DEFAULT))
        return String(bOut)
    }
}