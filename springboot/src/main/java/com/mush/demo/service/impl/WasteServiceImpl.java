package com.mush.demo.service.impl;

import com.mush.demo.entity.Waste;
import com.mush.demo.mapper.WasteMapper;
import com.mush.demo.service.IWasteService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class WasteServiceImpl extends ServiceImpl<WasteMapper, Waste> implements IWasteService {

}
