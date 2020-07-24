package com.study.jvm.chapter1;

import sun.security.ec.CurveDB;

import java.net.URL;

public class ClassLoadTest {
    public static void main(String[] args) {
        // 获取bootstrap class loader
        System.out.println("getting bootstrap class loader");
        URL[] urls = sun.misc.Launcher.getBootstrapClassPath().getURLs();
        for (URL ele:urls) {
            System.out.println(ele);
        }

        // 获取扩展类加载器
        System.out.println("getting extension class loader");
        String extDirs = System.getProperty("java.ext.dirs");
        for (String ele:extDirs.split(";")) {
            System.out.println(ele);
        }
        ClassLoader classLoader3 = CurveDB.class.getClassLoader();
        System.out.println(classLoader3);
        // get system classload
        ClassLoader classLoader = ClassLoader.getSystemClassLoader();
        System.out.println(classLoader);

        //获取上层：扩展类加载器
        ClassLoader extClassLoad = classLoader.getParent();
        System.out.println(extClassLoad);

        // 获取用户自定义的类的加载器
        ClassLoader classLoader1 = ClassLoadTest.class.getClassLoader();
        System.out.println(classLoader1);

        // string等系统的核心类库都是使用引导类加载器加载的 bootstrap class loader
        ClassLoader classLoader2 = String.class.getClassLoader();
        System.out.println(classLoader2);//null
    }
    /**
     * 1、虚拟机自带的加载器，使用C/C++语言编写，启动类加载器，bootstrap class loader
     * 只负责加载JVM自身需要的类，核心类库，string，rt.jar等
     * 2、扩展类加载器，extension classLoader
     *      实现方式：java编写，sun.misc.Launcher$ExtClassLoader实现；
     *              派生（？什么叫派生）于classLoader类
     *              加载jre/lib/ext子目录，java.ext.dirs
     * 3、系统类加载器？ todo
     * 4、用户自定义类加载器 ： 继承java.lang.classLoader，重写findClass()
     * protected Class<?> findClass(String name) throws ClassNotFoundException {
     *         throw new ClassNotFoundException(name);
     *     }
     * 5、了解classLoader加载类，抽象类
     *      常见方法：
     * 6、双亲委派机制【一个类只有一个类加载器】 ：
     * 类收到加载请求，一直向上请求【若该请求没有被请求到的加载器请求到成功】到引导类加载器，
     * 如果委托可以实现，则加载此类，若是无法加载再使用自定义类的加载器
     * 创建一个java.lang.string 并再其中加上main方法，观察其效果
     * 优势：
     *  避免类的重复加载
     *  防止核心代码被修改
     * 7、沙箱安全机制【保护java核心代码不被篡改】
     * 8、补充： 两个class对象是否为同一个类：
     *  1、包名类名一致
     *  2、加载器一致
     * 9、一个类是否主动被使用（若被主动使用的话，初始化中的<clinit>()方法会执行）
     *      创建类的实例；
     *      访问某个类或者接口的静态变量，或者对静态变量赋值
     *      调用类的静态方法
     *      反射 Class.forName("com.atguigu.Test")
     *      初始化一个类的子类
     *      Java虚拟机启动时被标明为启动类的类（todo ？）
     *      JDK7动态语言支持：
     *          java.lang.invoke.MethodHandle实例的解析结果
     *          REF_getStatic、REF_putStatic、FEF_invokeStatic句柄对应的类没有初始化，则初始化
     */
}
