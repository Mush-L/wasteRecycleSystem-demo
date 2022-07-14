package com.mush.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("sys_auuser")
@ApiModel(value = "Auuser对象", description = "审核用户")
public class Auuser implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("audit id")
    @TableId(value = "au_id", type = IdType.AUTO)
    private Integer auId;

    @ApiModelProperty("用户id")
    private Integer uId;

    @ApiModelProperty("用户昵称")
    private String uName;

    @ApiModelProperty("性别")
    private String uSex;

    @ApiModelProperty("年龄")
    private Integer uAge;

    @ApiModelProperty("电话")
    private Integer uPhone;

    @ApiModelProperty("电子邮箱")
    private String uEmail;

    @ApiModelProperty("用户信息修改原因")
    private String auReason;

    @ApiModelProperty("处理管理员")
    private String aAccount;

    @ApiModelProperty("审核意见")
    private String auResult;

    @ApiModelProperty("审核状态")
    private String auState;

    @ApiModelProperty("创建时间")
    private LocalDateTime updateTime;
}
