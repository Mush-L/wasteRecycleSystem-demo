package com.mush.demo.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mush.demo.common.Constants;
import com.mush.demo.common.Result;
import com.mush.demo.controller.dto.UserDTO;
import com.mush.demo.entity.User;
import com.mush.demo.service.IUserService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

/**
 * 前端控制器
 *
 * @author mush
 * @since 2022-04-26
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private IUserService userService;

    // 登录：返回登录对象
    @PostMapping("/login")
    public Result login(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUserAccount();
        String password = userDTO.getUserPassword();
        // 判断是否空
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        UserDTO dto = userService.login(userDTO);
        return Result.success(dto);
    }

    // 注册：返回注册对象
    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUserAccount();
        String password = userDTO.getUserPassword();
        // 判断是否空
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        User dto = userService.register(userDTO);
        return Result.success(dto);
    }

    // 新增或者更新：返回布尔
    @PostMapping
    public Result save(@RequestBody User user) {
        return Result.success(userService.saveOrUpdate(user));
    }

    // 根据 id 删除：返回布尔
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        User user = userService.getById(id);
        user.setUserState("Z");
        return Result.success(userService.updateById(user));
        // return Result.success(userService.removeById(id));
    }

    // 批量删除：返回布尔
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(userService.removeByIds(ids));
    }

    // 查询所有数据：返回列表
    @GetMapping
    public Result findAll() {
        return Result.success(userService.list());
    }

    // 根据 id 检索：返回对象
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(userService.getById(id));
    }

    @GetMapping("/account/{account}")
    public Result findByUsername(@PathVariable String account) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_account", account);
        return Result.success(userService.getOne(queryWrapper));
    }
    // 分页查询：返回列表
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String phone) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        // 只搜索状态码为 2 的用户
        queryWrapper.orderByDesc("user_id").like("user_state","B");
        if (!"".equals(username)) {
            queryWrapper.like("user_name", username);
        }
        if (!"".equals(phone)) {
            queryWrapper.like("user_phone", phone);
        }
        return Result.success(userService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    /**
     * 数据的导出
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<User> list = userService.list();
        // 通过工具类创建writer 写出到磁盘路径
        // ExcelWriter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xlsx");
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("userId", "ID");
        writer.addHeaderAlias("userName", "姓名");
        writer.addHeaderAlias("userAccount", "账号");
        writer.addHeaderAlias("userPassword", "密码");
        writer.addHeaderAlias("userState", "账号权限");
        writer.addHeaderAlias("userSex", "性别");
        writer.addHeaderAlias("userAge", "年龄");
        writer.addHeaderAlias("userPhone", "电话");
        writer.addHeaderAlias("createTime", "创建时间");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("用户信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();
    }

    /**
     * 通过 excel 导入
     */
    @PostMapping("/import")
    public Result imp(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        // 方式1：(推荐) 通过 javabean的方式读取Excel内的对象，但是要求表头必须是英文，跟javabean的属性要对应起来
        // List<User> list = reader.readAll(User.class);

        // 方式2：忽略表头的中文，直接读取表的内容
        List<List<Object>> list = reader.read(1);
        List<User> users = CollUtil.newArrayList();
        for (List<Object> row : list) {
            User user = new User();
            user.setUserId(Integer.parseInt(row.get(0).toString()));
            user.setUserName(row.get(1).toString());
            user.setUserAccount(row.get(2).toString());
            user.setUserPassword(row.get(3).toString());
            user.setUserState(row.get(4).toString());
            user.setUserSex(row.get(5).toString());
            user.setUserAge(Integer.parseInt(row.get(6).toString()));
            user.setUserPhone(Integer.parseInt(row.get(7).toString()));
            users.add(user);
        }

        userService.saveBatch(users);
        return Result.success(true);
    }
}
