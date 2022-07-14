package com.mush.demo.service.impl;

import com.mush.demo.entity.Warehouse;
import com.mush.demo.mapper.WarehouseMapper;
import com.mush.demo.service.IWarehouseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class WarehouseServiceImpl extends ServiceImpl<WarehouseMapper, Warehouse> implements IWarehouseService {

}
