// src/main/java/com/polycoffee/util/SecurityUtil.java
package util;

import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class SecurityUtil {
    // Mã hoá mật khẩu bằng SHA-256
    public static String hashSHA256(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedhash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder(2 * encodedhash.length);
            for (byte b : encodedhash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi mã hoá SHA-256", e);
        }
    }
}