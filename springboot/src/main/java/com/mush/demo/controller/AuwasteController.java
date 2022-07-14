package com.mush.demo.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mush.demo.common.Result;
import com.mush.demo.entity.Auwaste;
import com.mush.demo.service.IAuwasteService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/auwaste")
public class AuwasteController {

    @Resource
    private IAuwasteService auwasteService;

    // 新增或更新：返回布尔
    @PostMapping
    public Result save(@RequestBody Auwaste auwaste) {
        return Result.success(auwasteService.saveOrUpdate(auwaste));
    }

    // 根据 id 删除：返回布尔
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        Auwaste auwaste = auwasteService.getById(id);
        auwaste.setAuState("已完成");
        return Result.success(auwasteService.updateById(auwaste));
    }

    // 根据 id 数组批量删除：返回布尔
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(auwasteService.removeByIds(ids));
    }

    // 遍历数据库：返回列表
    @GetMapping
    public Result findAll() {
        return Result.success(auwasteService.list());
    }

    // 根据 id 检索：返回对象
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(auwasteService.getById(id));
    }

    // 分页检索：返回用户 id 的 page
    @GetMapping("/pageuid")
    public Result findPageByUId(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize,
                                @RequestParam Integer uid) {
        QueryWrapper<Auwaste> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("au_id").eq("u_id", uid);
        return Result.success(auwasteService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    // 分页检索：返回未完成
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Auwaste> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("au_id").eq("au_state", "未完成");
        return Result.success(auwasteService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    // 分页检索：返回列表
    @GetMapping("/pageall")
    public Result findPageAll(@RequestParam Integer pageNum,
                              @RequestParam Integer pageSize) {
        QueryWrapper<Auwaste> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("au_id");
        return Result.success(auwasteService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}
