package com.mush.demo.service;

import com.mush.demo.controller.dto.UserDTO;
import com.mush.demo.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 服务类
 *
 * @author mush
 * @since 2022-04-26
 */
public interface IUserService extends IService<User> {
    UserDTO login(UserDTO userDTO);

    User register(UserDTO userDTO);
}
