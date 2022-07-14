package com.mush.demo.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mush.demo.common.Result;
import com.mush.demo.entity.Waste;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.mush.demo.service.IWarehouseService;
import com.mush.demo.entity.Warehouse;

import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/warehouse")
        public class WarehouseController {
    
    @Resource
    private IWarehouseService warehouseService;

    // 新增或更新：返回布尔
    @PostMapping
    public Result save(@RequestBody Warehouse warehouse){
        return Result.success(warehouseService.saveOrUpdate(warehouse));
    }

    // 根据 id 删除：返回布尔
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        return Result.success(warehouseService.removeById(id));
    }

    // 根据 id 数组批量删除：返回布尔
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        return Result.success(warehouseService.removeByIds(ids));
    }

    // 遍历数据库：返回列表
    @GetMapping
    public Result findAll(){
        return Result.success(warehouseService.list());
    }

    // 根据 id 检索：返回对象
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id){
        return Result.success(warehouseService.getById(id));
    }

    // 分页检索：返回列表 种类、细分、入库管理员、状态
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String wtype2,
                           @RequestParam(defaultValue = "") String wtype3,
                           @RequestParam(defaultValue = "") String inAdmin,
                           @RequestParam(defaultValue = "入库") String wastate) {
        QueryWrapper<Warehouse> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("wa_id");
        if (!"".equals(wtype2)) {
            queryWrapper.like("w_type2", wtype2);
        }
        if (!"".equals(wtype3)) {
            queryWrapper.like("w_type3", wtype3);
        }
        if (!"".equals(inAdmin)) {
            queryWrapper.like("in_admin", inAdmin);
        }
        if (!"".equals(wastate)) {
            queryWrapper.like("wa_state", wastate);
        }
        return Result.success(warehouseService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}
