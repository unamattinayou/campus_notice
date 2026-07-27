package net.biancheng.schoolbbs.gen;



import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

public class CodeGenerator {
    public static void main(String[] args) {


            String url = "jdbc:mysql://localhost:3306/ry?useSSL=false&characterEncoding=utf8&serverTimezone=Asia/Shanghai";

// 使用 FastAutoGenerator 快速配置代码生成器
            FastAutoGenerator.create(url, "root", "root")
                    .globalConfig(builder -> {
                        builder.author("apache") // 设置作者
                                .outputDir("D:\\7.3.ov\\springboot3-ry-cafuc-master\\springboot3-ry-cafuc-master\\shopping\\src\\main\\java");
//                                .outputDir("C:\\workspace\\springboot3-ry-cafuc\\shopping\\src\\main\\java"); // 输出目录
                    })
                    .packageConfig(builder -> {
                        builder.parent("com.cafuc.shopping") // 设置父包名
                                .entity("bean") // 设置实体类包名
                                .mapper("mapper") // 设置 Mapper 接口包名
                                .service("service") // 设置 Service 接口包名
                                .serviceImpl("service.impl") // 设置 Service 实现类包名
                                .xml("mapper"); // 设置 Mapper XML 文件包名
                    })
                    .strategyConfig(builder -> {
                        builder.addInclude("oms_cart_item") // 设置需要生成的表名
                                .entityBuilder()
                                .enableLombok() // 启用 Lombok
                                .enableTableFieldAnnotation() // 启用字段注解
                                .controllerBuilder()
                                .enableRestStyle(); // 启用 REST 风格
                    })
                    .templateEngine(new FreemarkerTemplateEngine()) // 使用 Freemarker 模板引擎
                    .execute(); // 执行生成

        }
}