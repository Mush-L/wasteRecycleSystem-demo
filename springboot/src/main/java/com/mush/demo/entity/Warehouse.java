package com.mush.demo.entity;

import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("sys_warehouse")
@ApiModel(value = "Warehouse对象", description = "仓库表")
public class Warehouse implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("仓库存储ID")
    private Integer waId;

    @ApiModelProperty("唯一ID")
    private Integer wId;

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

    @ApiModelProperty("物品图片")
    private String wPhoto;

    @ApiModelProperty("描述")
    private String wDesc;

    @ApiModelProperty("物品状态：入库、出库")
    private String waState;

    @ApiModelProperty("入库管理员")
    private String inAdmin;

    @ApiModelProperty("入库时间")
    private LocalDateTime createTime;

    @ApiModelProperty("出库管理员")
    private String outAdmin;

    @ApiModelProperty("出库时间")
    private LocalDateTime updateTime;
}
