package com.mush.demo.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@TableName("sys_file")
@ApiModel(value = "File对象")
public class Files implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("文件ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("文件名称")
    private String name;

    @ApiModelProperty("文件类型")
    private String type;

    @ApiModelProperty("文件大小（kb）")
    private Long size;

    @ApiModelProperty("下载连接")
    private String url;

    @ApiModelProperty("文件md5")
    private String md5;

    @ApiModelProperty("是否删除")
    private Boolean isDelete;

    @ApiModelProperty("是否禁用连接")
    private Boolean enable;
}
