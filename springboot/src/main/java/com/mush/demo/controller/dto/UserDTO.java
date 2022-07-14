package com.mush.demo.controller.dto;

import lombok.Data;

/**
 * 接受前端登录请求的参数
 */
@Data
public class UserDTO {
    private Integer userId;
    private String userName;
    private String userAccount;
    private String userPassword;
    private String userState;
    private String token;
}
