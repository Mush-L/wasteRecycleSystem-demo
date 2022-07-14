package com.mush.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * @author mush
 * @since 2022-04-26
 */
@Getter
@Setter
@TableName("sys_user")
@ApiModel(value = "User对象", description = "")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("用户ID")
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    @ApiModelProperty("用户名")
    private String userName;

    @ApiModelProperty("用户账号")
    private String userAccount;

    @ApiModelProperty("密码")
    @JsonIgnore
    private String userPassword;

    @ApiModelProperty("账号权限")
    private String userState;

    @ApiModelProperty("性别")
    private String userSex;

    @ApiModelProperty("年龄")
    private Integer userAge;

    @ApiModelProperty("电话")
    private Integer userPhone;

    @ApiModelProperty("创建时间")
    private Date createTime;
}
