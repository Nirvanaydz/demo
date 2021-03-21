package ioTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomUtils;

/**
 * java中的IO学习
 * @author yudazhi
 */
@Slf4j
public class IoTestMain {
    public static final String FILE_PATH = "C:\\code\\demo\\src\\main\\java\\ioTest\\1.txt";
    public static void main(String[] args) {
        new IoTestMain().fullWriteByByte();
    }

    /**
     * 字节流的方式单次读取，使用字节流的方式直接将read的值转换成int，标准写法
     */
    private void singleReadByInt() {
        int result = 0;
        FileInputStream fileInputStream = null;
        try {
            File file = new File(FILE_PATH);
            fileInputStream = new FileInputStream(file);
            result = fileInputStream.read();
            log.info("read line is : {}", result);
        } catch (IOException e) {
            log.error("singleReadByInt >>> e :", e);
        } finally {
            IOUtils.closeQuietly(fileInputStream);
        }
    }

    /**
     * 字节流的方式多次读取文件
     */
    private void fullReadByInt() {
        int value = 0;
        FileInputStream fileInputStream = null;
        try {
            File file = new File(FILE_PATH);
            fileInputStream = new FileInputStream(file);
            while (-1 != (value = fileInputStream.read())){
                log.info("read line is : {}", value);
            }
        } catch (IOException e) {
            log.error("fullReadByInt >>> e :", e);
        } finally {
            IOUtils.closeQuietly(fileInputStream);
        }
    }

    /**
     * 字符流的方式读取文件，速度快
     */
    private void fullReadByByte() {
        int value = 0;
        FileInputStream fileInputStream = null;
        try {
            File file = new File(FILE_PATH);
            fileInputStream = new FileInputStream(file);
            // 不同之处
            byte[] bt = new byte[1024];
            while (-1 != (value = fileInputStream.read(bt))){
                String s = new String(bt,0,value);
                log.info("read line is : {}", s);
            }
        } catch (IOException e) {
            log.error("fullReadByByte >>> e :", e);
        } finally {
            IOUtils.closeQuietly(fileInputStream);
        }
    }

    /**
     * 输出流
     */
    private void fullWriteByByte() {
        FileOutputStream fileOutputStream = null;
        try {
            int num = RandomUtils.nextInt();
            fileOutputStream = new FileOutputStream(new File(num+"输出流.txt"));
            // 不同之处
            fileOutputStream.write("没有绝对的绝缘体，只有不努力的电压".getBytes());
        } catch (IOException e) {
            log.error("fullWriteByByte >>> e :", e);
        } finally {
            IOUtils.closeQuietly(fileOutputStream);
        }
    }

}
