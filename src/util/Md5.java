package util;

import java.security.MessageDigest;

public class Md5 {

    /**
     * 标准MD5加密
     *
     * @param inStr
     * @return
     * @throws Exception
     */
    public static String toMD5(String inStr) {
        StringBuffer sb = new StringBuffer();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(inStr.getBytes());
            byte b[] = md.digest();
            int i;
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    sb.append("0");
                sb.append(Integer.toHexString(i));
            }
        } catch (Exception e) {
            return null;
            //          e.printStackTrace();
        }
        return sb.toString().toUpperCase();
    }
}