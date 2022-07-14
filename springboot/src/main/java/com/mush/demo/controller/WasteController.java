package com.mush.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mush.demo.common.Result;
import com.mush.demo.entity.Waste;
import com.mush.demo.service.IWasteService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/waste")
public class WasteController {

    @Resource
    private IWasteService wasteService;

    // 新增或更新：返回布尔
    @PostMapping
    public Result save(@RequestBody Waste waste) {
        return Result.success(wasteService.saveOrUpdate(waste));
    }

    // 根据 id 删除：返回布尔
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        Waste waste = wasteService.getById(id);
        waste.setTState("已取消");
        return Result.success(wasteService.updateById(waste));
//        return Result.success(wasteService.removeById(id));
    }

    // 根据 id 数组批量删除：返回布尔
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(wasteService.removeByIds(ids));
    }

    // 遍历数据库：返回列表
    @GetMapping
    public Result findAll() {
        return Result.success(wasteService.list());
    }

    // 根据 id 检索：返回对象
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(wasteService.getById(id));
    }

    // 根据用户 id 分页检索：返回列表 名称
    @GetMapping("/pageuid")
    public Result findPageByUid(@RequestParam Integer pageNum,
                                   @RequestParam Integer pageSize,
                                   @RequestParam Integer uid,
                                   @RequestParam(defaultValue = "") String wname) {
        QueryWrapper<Waste> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("w_id").eq("u_id", uid);
        if (!"".equals(wname)) {
            queryWrapper.like("w_name", wname);
        }
        return Result.success(wasteService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    // 分页检索：返回列表 名称、种类、细分、地区、地址
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String wname,
                           @RequestParam(defaultValue = "") String wtype2,
                           @RequestParam(defaultValue = "") String wtype3,
                           @RequestParam(defaultValue = "") String taddress1,
                           @RequestParam(defaultValue = "") String taddress2,
                           @RequestParam(defaultValue = "") String tstate) {
        QueryWrapper<Waste> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("w_id").ne("t_state", "已取消");
        if (!"".equals(wname)) {
            queryWrapper.like("w_name", wname);
        }
        if (!"".equals(wtype2)) {
            queryWrapper.like("w_type2", wtype2);
        }
        if (!"".equals(wtype3)) {
            queryWrapper.like("w_type3", wtype3);
        }
        if (!"".equals(taddress1)) {
            queryWrapper.like("t_address1", taddress1);
        }
        if (!"".equals(taddress2)) {
            queryWrapper.like("t_address2", taddress2);
        }
        if (!"".equals(tstate)) {
            queryWrapper.like("t_state", tstate);
        }
        return Result.success(wasteService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}
