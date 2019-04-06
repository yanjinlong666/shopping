package com.fh.shop.backend.biz.member;

import com.fh.core.common.DataTableResult;
import com.fh.core.common.ResponseEnum;
import com.fh.core.common.ServiceResponse;
import com.fh.core.util.DateUtil;
import com.fh.shop.backend.mapper.member.IMemberMapper;
import com.fh.shop.backend.po.member.Member;
import com.fh.shop.backend.vo.MemberVo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("memberService")
public class IMemberServiceImpl implements IMemberService {

    @Resource
    private IMemberMapper memberMapper;

    @Override
    public DataTableResult buildDataTable(Member member) {
        //分页赋值
        member.setStart(member.getStart());
        member.setLength(member.getLength());
        //查询总条数
        Long totalCount = memberMapper.queryTotalCount(member);
        //查询数据
        List<Member> memberList = memberMapper.list(member);
        //PO转VO
        List<MemberVo> memberVoList = new ArrayList<>();
        for (Member memberDB : memberList) {
            MemberVo memberVo = new MemberVo();
            memberVo.setId(memberDB.getId());
            memberVo.setUserName(memberDB.getUserName());
            memberVo.setPhone(memberDB.getPhone());
            memberVo.setEmail(memberDB.getEmail());
            memberVo.setBirthday(DateUtil.date2Str(memberDB.getBirthday(),DateUtil.Y_M_D));
            memberVo.setAreaNames(memberDB.getAreaNames());
            memberVoList.add(memberVo);
        }
        //组装数据
        return DataTableResult.buildDataTableResult(member.getDraw(),totalCount,totalCount,memberVoList);
    }

    @Override
    public MemberVo queryMemberById(Integer id) {
        Member member = memberMapper.queryMemberById(id);
        //po转vo
        MemberVo memberVo = new MemberVo();
        memberVo.setId(member.getId());
        memberVo.setUserName(member.getUserName());
        memberVo.setEmail(member.getEmail());
        memberVo.setBirthday(DateUtil.date2Str(member.getBirthday(),DateUtil.Y_M_D));
        memberVo.setAreaNames(member.getAreaNames());
        return memberVo;
    }

    @Override
    public ServiceResponse updateMember(Member member) {
        //判断用户名是否重复
        List<Member> memberList = memberMapper.queryMemberByName(member.getUserName());
        if (memberList.size() == 1 || memberList.size() == 0){
            memberMapper.updateMember(member);
            return ServiceResponse.success();
        }
        return ServiceResponse.error(ResponseEnum.ERROR_USERNAME_EXIST);
    }
}
