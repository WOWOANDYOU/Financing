package cn.edu.zhku.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.edu.zhku.pojo.SelectSumPojo;
import cn.edu.zhku.pojo.SpendCategory;
import cn.edu.zhku.pojo.SpendRecord;

public interface SpendMapper {
	public int addSpendCate(SpendCategory spendCate);
	public int deleteSpendCate(int id);
	public SpendCategory querySpendCateName(int id);
	public List<SpendCategory> queryAllSpendCate();
	public int addSpendRecord(SpendRecord spendRecord);
	public List<SpendRecord> queryAllSpendRecord();
	public List<SpendRecord> querySpendRecordDate(Date date, int start, int end);
	public List<SpendRecord> querySpendRecordDate2(Date date);
	public SpendRecord querySpendRecord(int id);
	public List<SpendRecord> querySpendRecordByDateUserId(Map map);
	public List<SelectSumPojo> queryMonthNumdata(Map map);
	public List<SelectSumPojo> querySpendCateData(Map map);
}
