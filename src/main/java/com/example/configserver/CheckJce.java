package com.example.configserver;

import java.security.NoSuchAlgorithmException;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

public class CheckJce {
    public static void validate() throws Exception {
        String message = "Java Cryptography Extension (JCE) Unlimited Strength is NOT correctly installed!";
        int maxKeyLength = Cipher.getMaxAllowedKeyLength("AES");

        // try to use a non-limited key size to see whether the Java Cryptography
        // Extension (JCE) Unlimited Strength is correctly installed.  without it
        // the maximum key size are limited to 128-bit.

        try {
            KeyGenerator generator = KeyGenerator.getInstance("AES");

            generator.init(256);

            SecretKey key = generator.generateKey();

            Cipher encryptCipher = Cipher.getInstance("AES");
            encryptCipher.init(Cipher.ENCRYPT_MODE, key);

            byte[] encryptedData = encryptCipher.doFinal(message.getBytes("utf-8"));

            Cipher decryptCipher = Cipher.getInstance("AES");
            decryptCipher.init(Cipher.DECRYPT_MODE, key);

            byte[] decryptedData = decryptCipher.doFinal(encryptedData);

            String decryptedMessage = new String(decryptedData, "utf-8");

            if (!message.equals(decryptedMessage)) {
                throw new Exception("decrypted message is not the same as original message?!");
            }
        }
        catch (NoSuchAlgorithmException e) {
            e.printStackTrace(System.err);
            System.err.printf("\nYou need to install Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files from http://www.oracle.com/technetwork/java/javase/downloads/index.html\n\n");
            System.err.printf("JAVA_HOME is at %s\n\n", System.getProperty("java.home"));
            System.getProperties().list(System.err);
            throw e;
        }
    }
}