package com.mush.demo.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mush.demo.common.Constants;
import com.mush.demo.controller.dto.UserDTO;
import com.mush.demo.entity.User;
import com.mush.demo.exception.ServiceException;
import com.mush.demo.mapper.UserMapper;
import com.mush.demo.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mush.demo.utils.TokenUtils;
import org.springframework.stereotype.Service;

/**
 * 服务实现类
 *
 * @author mush
 * @since 2022-04-26
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    private static final Log LOG = Log.get();

    @Override
    public UserDTO login(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        // 用户存在，且账号未被禁用
        if (one != null && !"Z".equals(one.getUserState())) {
            // 太罪恶了，这里规范了大小写，其他表没有！！！
            BeanUtil.copyProperties(one, userDTO, true);
            String token = TokenUtils.genToken(one.getUserId().toString(), one.getUserPassword());
            userDTO.setToken(token);
            return userDTO;
        } else {
            throw new ServiceException(Constants.CODE_600, "用户名或密码错误");
        }
    }

    @Override
    public User register(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one == null) {
            one = new User();
            BeanUtil.copyProperties(userDTO, one, true);
            save(one);  // 把 copy后的用户对象存储到数据库
        } else {
            throw new ServiceException(Constants.CODE_600, "用户已存在");
        }
        return one;
    }

    // 封装方法，进行校验
    private User getUserInfo(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_account", userDTO.getUserAccount());
        queryWrapper.eq("user_password", userDTO.getUserPassword());
        User one;
        try {
            one = getOne(queryWrapper); // 从数据库查询用户信息
        } catch (Exception e) {
            LOG.error(e);
            throw new ServiceException(Constants.CODE_500, "系统错误");
        }
        return one;
    }
}