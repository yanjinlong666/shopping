package com.fh.shop.backend.biz.member;

import com.fh.core.common.DataTableResult;
import com.fh.core.common.ServiceResponse;
import com.fh.shop.backend.po.member.Member;
import com.fh.shop.backend.vo.MemberVo;

public interface IMemberService {

    DataTableResult buildDataTable(Member member);

    MemberVo queryMemberById(Integer id);

    ServiceResponse updateMember(Member member);
}
