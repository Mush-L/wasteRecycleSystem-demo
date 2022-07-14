package com.mush.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("sys_auwaste")
@ApiModel(value = "Auwaste对象", description = "任务信息的修改审核")
public class Auwaste implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("audit的id")
    @TableId(value = "au_id", type = IdType.AUTO)
    private Integer auId;

    @ApiModelProperty("物品id")
    private Integer wId;

    @ApiModelProperty("用户id")
    private Integer uId;

    @ApiModelProperty("名称，可有可无")
    private String wName;

    @ApiModelProperty("大类")
    private String wType1;

    @ApiModelProperty("小类")
    private String wType2;

    @ApiModelProperty("详情")
    private String wType3;

    @ApiModelProperty("重量")
    private Double wW;

    @ApiModelProperty("体积")
    private Double wV;

    @ApiModelProperty("描述")
    private String wDesc;

    @ApiModelProperty("任务日期")
    private LocalDate tDate;

    @ApiModelProperty("任务地址1")
    private String tAddress1;

    @ApiModelProperty("任务地址2")
    private String tAddress2;

    @ApiModelProperty("任务图片地址")
    private String tPhoto;

    @ApiModelProperty("任务描述")
    private String tDesc;

    @ApiModelProperty("任务修改原因")
    private String auReason;

    @ApiModelProperty("处理管理员")
    private String aAccount;

    @ApiModelProperty("审核意见")
    private String auResult;

    @ApiModelProperty("审核状态")
    private String auState;

    @ApiModelProperty("修改时间")
    private LocalDateTime updateTime;
}
