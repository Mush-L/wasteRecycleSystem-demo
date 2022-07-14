package com.mush.demo.service.impl;

import com.mush.demo.entity.Files;
import com.mush.demo.mapper.FileMapper;
import com.mush.demo.service.IFileService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class FileServiceImpl extends ServiceImpl<FileMapper, Files> implements IFileService {

}
