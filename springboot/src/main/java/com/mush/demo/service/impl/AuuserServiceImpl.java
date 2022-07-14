package com.mush.demo.service.impl;

import com.mush.demo.entity.Auuser;
import com.mush.demo.mapper.AuuserMapper;
import com.mush.demo.service.IAuuserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class AuuserServiceImpl extends ServiceImpl<AuuserMapper, Auuser> implements IAuuserService {

}
