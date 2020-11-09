<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
			
	<!-- 	<tr name="revTr">
            <td class="ag_c"><span class="fc_gray ft-s12">P.REV (예상 매출)</span></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_r" value=0 /></td>
            <td class="cellend total"><span class="total" name="totalDivisionRev">0</span></td>
        </tr>
        <tr name="gpTr">
            <td class="ag_c border_gap"><span class="fc_gray ft-s12">P.GP (예상 이익)</span></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap"><input type="text"  onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" name="amount_g" value=0 /></td>
            <td class="border_gap cellend total"><span class="total" name="totalDivisionGp">0</span></td>
        </tr> -->
        
       <!--  <tr name="revTr">
            <td class="ag_c border_gap"><span name="quarterDy"></span></td>
            <td><input type="text"  name="amount_r" onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" value=0 /></td>
            <td><input type="text"  name="amount_g" onClick="oppSalesPlan.zero(this);" onblur="oppSalesPlan.blur(this);" OnKeyUp="comma(this);oppSalesPlan.quarterSum();oppSalesPlan.divisionSum();" class="form-control" value=0 /></td>
        </tr>
        -->
        