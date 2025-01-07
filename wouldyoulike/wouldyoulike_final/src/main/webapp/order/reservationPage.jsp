<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="wouldyoulike.order.cartDAO" %>
<%@ page import="wouldyoulike.order.cartDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 페이지 입니다.</title>

	<%

request.setCharacterEncoding("UTF-8");
String proName = request.getParameter("proName");
String img = request.getParameter("img");
int productN = Integer.parseInt(request.getParameter("productN"));//상품번호
int amount = Integer.parseInt(request.getParameter("amount")); //상품주문수량
int price = Integer.parseInt(request.getParameter("price")); //상품주문가격
int sum = price * amount; //총주문가격

%>
</head>

<%
	String id = (String) session.getAttribute("sid");
	if(id==null){
%>		<script>
			alert("로그인이 필요한 페이지 입니다!");
			window.location="/wouldyoulike_final/member/loginForm.jsp";
		</script>
<%	}
%>

<body>
<div>
           <div>
                <h2>주문서작성/결제</h2>
                <ol>
                    <li><span>01</span> 장바구니 <span></li>
                    <li class="page_on"><span>02</span> 주문서작성/결제</li>
                    <li><span>03</span> 주문완료</li>
                </ol>
            </div>
            <!-- //order_tit -->
            <div class="order_cont">
                <div class="cart_cont_list">
                
                    <div class="order_cart_tit">
                        <h3>주문상세내역</h3>
                    </div>
                    <!-- //order_cart_tit -->

                    <div class="order_table_type">
                        <!-- 장바구니 상품리스트 시작 -->
                        <table>
                            <colgroup>
                                <col>					<!-- 상품명/옵션 -->
                                <col style="width:5%">  <!-- 수량 -->
                                <col style="width:10%"> <!-- 상품금액 -->
                                <col style="width:13%"> <!-- 할인/적립 -->
                                <col style="width:10%"> <!-- 합계금액 -->

                            </colgroup>
                            <thead>
                            <tr>
                                <th>상품/옵션 정보</th>
                                <th>수량</th>
                                <th>상품금액</th>
                                <th>합계금액</th>
                            </tr>
                            <th></th>




 
                    


                            <tr>
							<th><%=img%><%=proName%></th>
                            <th> <strong><%=amount %>개</strong></th>
                            <th><%=price%>원</th>
                            <th><%=sum%>원</th>
                            <th></th>
                            </tr>
                            </thead>
                            <tbody>
                          
                            <tr>
                                <td>
                                      </span>
                                        <div>
									 
                                            <!-- //icon_pick_list -->

                                            <div class="pick_option_box">
                                            </div>

                                            <div class="pick_option_box">
                                            </div>
                                        </div>
                                    </div>
                       
                                </td>
                                <td class="td_order_amount">
                                    <div class="order_goods_num">
                                       
                                    </div>
                                </td>
                                <td>
                                    <strong class="order_sum_txt price"></strong>
                                </td>
                                <td class="td_benefit">
                                    <ul class="benefit_list">
                                    </ul>
                                </td>
                                <td>
                                    <strong class="order_sum_txt"></strong>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                        <!-- 장바구니 상품리스트 끝 -->
                    </div>
<form action="reservationPro.jsp?proNum=<%=productN%>" name="frm" method="post">
                </div>
                <!-- //cart_cont_list -->
                <div class="btn_left_box" style="display:none;">
                    <a href="./cart.php" class="shop_go_link"><em>&lt; 장바구니 가기</em></a>
                </div>

                <div class="price_sum">
                    
                            <dl>
                                <dd align="center"> <strong>합계 :<%=sum %> 원</strong></dd>
                            </dl>
                      
                    </div>
                    
                    <!-- //price_sum_cont -->
                </div>
                <!-- //price_sum -->
                     
                    <div class="order_agree" style="margin-top:10px;">
                       
                            <h4>주문에 대한 개인정보 수집 이용 동의</h4>
                            <div>
    <textarea readonly style="width:450px;height:100px">
1. 목적 : 지원자 개인 식별, 지원의사 확인, 입사전형의 진행, 고지사항 전달, 입사 지원자와의 원활한 의사소통, 지원이력 확인 및 면접 불합격자 재지원 제한
2. 항목 : 아이디(이메일주소), 비밀번호, 이름, 생년월일, 휴대폰번호
3. 보유기간 : 회원 탈퇴 시까지 보유 (단, 지원이력 정보는 일방향 암호화하여 탈퇴일로부터 1년간 보관 후 파기합니다.)</textarea>
                        </div>
                        
                                   <input type="checkbox" id="termAgree" required/>
                                    <label for="termAgree_guest" class="check_s"><strong>(필수) </strong>개인정보 수집 이용에 대한 내용을 확인 하였으며 이에 동의 합니다.</label>
                       
                            <h4>이용약관 동의</h4>
                       
                        <textarea readonly style="width:450px;height:100px">
1.고객은 본 약관에 따라 본 서비스를 이용해야 합니다. 고객은 본 약관에 대해 동의를 했을 경우에 한하여 본 서비스를 이용할 수 있습니다.
2.고객이 미성년자일 경우에는 친권자 등 법정대리인의 사전 동의를 얻은 후 본 서비스를 이용하십시오. 또한 고객이 본 서비스를 사업자를 위해 이용할 경우에는 당해 사업자 역시 본 약관에 동의한 후, 본 서비스를 이용하십시오.
3.본 서비스에 적용되는 개별 이용약관이 존재할 경우, 고객은 본 약관 외에 개별 이용약관의 규정에 따라 본 서비스를 이용해야 합니다.
4.본 서비스 이용을 위해 고객은 특정 정보를 등록하여 계정을 생성해야 할 수 있습니다. 고객은 진실하고 정확하며 완전한 정보를 등록해야 하며 언제나 최신 정보가 적용되도록 수정해야 합니다.
5.고객이 본 서비스 이용을 위해 인증 정보를 등록할 경우, 이를 부정하게 이용당하지 않도록 본인 책임 하에 엄중하게 관리해야 합니다. LINE은 등록된 인증 정보를 이용하여 이루어진 일체의 행위를 인증 정보를 등록한 고객 본인의 행위로 간주할 수 있습니다.
6.본 서비스에 등록한 고객은 언제라도 계정을 삭제하고 탈퇴할 수 있습니다.
7.고객이 본 서비스에서 가지는 모든 이용 권한은 이유를 막론하고 계정이 삭제된 시점에 소멸됩니다. 고객의 실수로 계정을 삭제한 경우에도 계정을 복구할 수 없음에 유의하시기 바랍니다.
8.본 서비스의 계정은 고객에게 일신전속적으로 귀속됩니다. 고객이 본 서비스에서 가지는 모든 이용권은 제삼자에게 양도, 대여 또는 처분할 수 없으며, 제삼자에게 상속 또는 승계될 수 없습니다.</textarea>
                         
                        
                                
                                    <br><input type="checkbox" id="termAgree2" required/>
                                    <label for="termAgree_agreement" class="check_s"><strong>(필수)</strong> 이용약관에 대한 내용을 확인 하였으며 이에 동의 합니다.</label>
                         
                    </div>
                   
             
               <br>               
<div id="map" style="width:350px;height:350px;">
</div><br>
<strong>직접 수령시 받을 장소입니다.</strong>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2cbc3fa8294a681084ca49a57ab6e80f"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.55497420411008, 126.93601784949539), // 지도의 중심좌표
        level: 1 // 지도의 확대 레벨
    };
// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
//마커가 표시될 위치입니다
var markerPosition = new kakao.maps.LatLng(37.55497420411008, 126.93601784949539);
// 마커를 생성합니다
var marker = new kakao.maps.Marker({
position: markerPosition
});
// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

</script>

<strong>수령 방식을 정해주세요.</strong><br>

직접수령 <input type="radio" name="pick" value="직접수령" required/> 
택배수령 <input type="radio" name="pick" value="택배수령" required/><br><br>
<strong>결제 수단을 선택해주세요.</strong><br>
신용카드 <input type="radio" name="pay" value="카드결제" required/>
현장결제 <input type="radio" name="pay" value="현금결제" required/>
<div class="order_info">
                        <div class="order_zone_tit">
                            <h4>주문자 정보</h4>
                            
                        </div>
                        <div class="order_table_type">
                            <table class="table_left">
                                <colgroup>
                                    <col style="width:15%;">
                                    <col style="width:85%;">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th>ID</th>
                                    <td><input type="text" name="memberID" id="memberID" value="" data-pattern="gdEngKor" maxlength="20" required>
                                      
                                   </td>
                                </tr>
                                <tr>
                                    <th>나이</th>
                                    <td>
                                        <input type="number" id="guestAge" name="guestAge" value="" maxlength="20" required> <button type="button" onclick="ageCheck()">나이확인</button><span style="color: #ff0000;">  (19세 미만은 구매가 불가능합니다.)</span>
                        <script>                
    function ageCheck(){
    	
    	var a = document.getElementById("guestAge").value;
    	
    	if(a < 20){
    		alert('20세 미만은 주류를 구매할 수 없습니다.')
    		
    	}
    	else{
    		alert('확인 되었습니다.')
    	}
    	
    	/*function btnCheck(){
    		
    		if(clickCheck == 1){
    			alert('확인')
    		}
    		else{
    			alert('나이체크를 해주세요.')
    		}
    	}*/
    	
    }

  </script>   
  
                                    </td>
                                </tr>
                                <tr>
                                    <th>휴대폰 번호</span></th>
                                    <td>
                                         <input type="number" id="mobilenum" name="mobilenum" value="" maxlength="11" required>
                                     
										<span style="color: #ff0000;">(구매예약시 본인확인을 위해 정확하게 기재해주시기 바랍니다)</span>
										<tr>
                                    <th>주문자 성함</th>
                                    <td><input type="text" name="ordername" id="ordername" value="" data-pattern="gdEngKor" maxlength="20" required>
                                      
                                    </td>
                                </tr>
                           <!-- 
                                    <<th>제품번호</span></th>
                                    <td>
                                        <input type="number" id="proNum" name="proNum" value="" maxlength="20" required>
                                     </td>
                                     </tr>  
                                 -->
                                
                                    <!--  <th>주문번호</span></th>
                                    <td>
                                         <input type="number" id="orderNum" name="orderNum" value="" maxlength="20" required> 
                                     
                                     </td>
                                     </tr>-->
                             
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <input type="hidden" name="orderamount" value="<%=amount%>"/>
                    <input type="hidden" name="pricesum" value="<%=sum%>"/>
                      <input type="submit" value="구매예약" onclick="return btnCheck();"/><input type="button" value="취소하기" onclick="back()"/>
                           
                         
                             
                             <!--function btnClick() {
    	
    	
  			alert('확인');
    		window.location ="orderPage.jsp";
    
    	var chk1 = document.frmJoin.U_termAgree.checked;
    	var chk2 = document.frmJoin.U_termAgree_agreement.checked;
    	
 
    	  if(!chk1){
              alert('약관1에 동의해 주세요');
              return false;
          } 
          if(!chk2) {
              alert('약관2에 동의해 주세요');
              return false;
          }--><script>
function back(){
	
	history.go(-1);
	
}
</script>
       
                    </form>
                    
                         
        </body>
</html>