<h1><p align="center"> 주류 판매 쇼핑몰 Would you(酒) Like? 🍷</p></h1>


### 주의사항 
프로젝트 기동 시, 필요한 키 값들이 보안상의 이유로 제거 되어 있기 때문에 빌드해도 동작하지 않습니다.

### 개요
프로젝트 기간 : 2022.04 ~ 2022.05<br>
프로젝트 이름: Would you(酒) Like? 🍷<br>
개발언어: JAVA11, JSP2.3<br>
DBMS : ORACLE SQL12C<br>
API : Chart.js<br>
멤버: 김재엽,문기용,이예지,임수민,조성혁<br>

### 프로젝트 설명
Would you(酒) Like? 는 다양한 와인들을 와인 종류, 원산지, 가격대, 도수 등 자신의 취향에 맞는 와인들을 구경하거나 구매할 수 있는 주류 쇼핑몰 사이트 입니다.<br>
검색을 통해 주류 취향이 비슷한 다른 유저들과 게시판에서 소통할 수 있습니다.<br>
쇼핑몰에서 상품구매 후 리뷰와 평점을 다른 유저들과 공유할 수 있습니다.

### 기능
김재엽 : 고객센터 문의, FQA, 게시판, 관리자 페이지<br>
문기용 : 주문 장바구니, 결제, 주문 내역 페이지<br>
이예지 : 상품 관리, 상품 필터링 페이지<br>
임수민 : 회원 관리(가입, 로그인, 탈퇴, 내 정보, 회원 정보 수정, 주문 내역 보기)<br>
조성혁 : 관리자 상품 관리(목록, 등록, 수정, 삭제), 회원 관리(목록, 탈퇴)

### 메인화면
![image](https://github.com/user-attachments/assets/6888c029-4bde-4a9e-b72c-47483b787647)


### 주요코드 (주문관리)

```
<%
	String id = (String) session.getAttribute("sid");
	if(id==null){
%>
     <script>
			alert("로그인이 필요한 페이지 입니다!");
			window.location="/wouldyoulike_final/member/loginForm.jsp";
		</script>
<%	}
%>

 <%
request.setCharacterEncoding("UTF-8");
orderDAO dao = new orderDAO();
String memberid = (String)session.getAttribute("sid");
int option = 0;
String strOption = request.getParameter("option");
ArrayList<orderDTO> list=null;
if(strOption != null){
	option = Integer.parseInt(strOption);
}
if(option == 0){
	list = dao.getCheckBuyInfo(memberid);
}else if(option == 1){
	list = dao.getBuyInfo(memberid);
}

%>

주문체크전 로그인 확인


```
```
  <%if(list.size()> 0){
	     for(orderDTO dto : list){ %>
	     	<tr>
	         <th><%=dto.getordername() %></th>
	         <th><%=dto.getmobilenum() %></th>
			<%	ProductDAO pdao = new ProductDAO();
				ProductDTO pdto = pdao.getData(dto.getproductNum());
				String productImg = pdto.getImg();
				String productName = pdto.getName();
			%>
	         <th><a href="../product/product.jsp?productN=<%=dto.getproductNum()%>">
	         	<img src="/wouldyoulike_final/img/product/<%=pdto.getImg() %>" height="32px" /><%=pdto.getName() %>
	         </a></th>
	         <th><%=dto.getorderamount() %></th>
	         <th><%=dto.getpricesum() %></th>
	         <th><%=dto.getreceive()%></th>
	         <th><%=dto.getpayment()%></th>
	         <th><%=dto.getordercomplete()%></th>
	         <th><%=dto.getorderDate()%></th>
	        </tr>
	<%}} %>

ORDERHISTORY 일부

```

```
<%
	request.setCharacterEncoding("UTF-8");
	String productN = request.getParameter("productN");
	String memberID = (String)session.getAttribute("sid");
	int amount = 1;
	if(request.getParameter("amount") != null){
		amount = Integer.parseInt(request.getParameter("amount"));
	}
	int nproductN=0;
	if(productN != null){
		nproductN = Integer.parseInt(productN);
	}

	cartDAO dao = new cartDAO();
	int result = dao.cartUpdate(nproductN, memberID,amount); 
	
	
	response.sendRedirect("cart.jsp");
%>
ADD CARTPRO JSP

```

```
<%
request.setCharacterEncoding("UTF-8");

String id =(String)session.getAttribute("sid");

String cid=null, cpw=null, cauto=null;
Cookie [] cookies = request.getCookies();

if(id==null){
	if(cookies != null){
		for(Cookie c :cookies){
			String cname = c.getName();
			if(cname.equals("cid")) cid=c.getValue();
			if(cname.equals("cpw")) cpw=c.getValue();
			if(cname.equals("cauto")) cauto=c.getValue();
		}
	}
	if(cauto != null && cid != null && cpw != null){
		response.sendRedirect("/wouldyoulike_final/member/loginPro.jsp");
	}
	response.sendRedirect("../member/loginForm.jsp");
}

cartDAO dao = new cartDAO();
ArrayList<cartDTO> list = dao.getcartInfo(id);


%>
	<h2 style="margin-top:5%; margin-left:10%"><%=id %>님의 장바구니</h2>
	<form action="reservationPage2.jsp" name="frm" method="post">
		<input type="hidden" name="id" value="<%=id%>"/>
		<table>
			<tr align="center">
				<th></th> <!-- 열맞추기용  -->
				<th>상품이름</th>
				<th>상품금액</th>
				<th>수량</th>
				<th></th>
			</tr>
	         	<%
         		if(list.size()>0){
	         		for(cartDTO dto : list){ 
	         			int price = dao.productPrice(dto.getproductN());
	         	%>
					<tr id ="tr1" align="center">
						<td><input type="checkbox" name="cartlist" value="<%=dto.getproductN()%>"/></td>
    					<td><a href="../product/product.jsp?productN=<%=dto.getproductN()%>"><%=dto.getname()%></a></td>
    					<td><%=price%></td>
	         			<td><input type="number" name ="<%=dto.getproductN()%>" value ="<%=dto.getamount()%>" id="option" min="1" max="9"></td>
	          			<td align="left">
	          				<input type="button" onclick="location.href='deleteCart.jsp?id=<%=dto.getmemberID()%>&productN=<%=dto.getproductN()%>';"value="삭제하기" />
						</td>
					</tr>
	           <%	}%>
	        <tr>  
				<td colspan="7">
					<input type="submit" value="선택상품 구매" style="float:right;"/>
					<input type="button" value="뒤로가기" onclick="back()"/>
				</td>
			</tr>
			<%}else{%>
				<tr>
					<td></td>
					<td colspan=3>장바구니가 비었습니다.</td>
				</tr>
			<%} %>
		</table>
	</form>
<script>
function back(){
	
	history.go(-1);
	
}
```
CART.JSP
### 진행하면서 아쉬웠던 점
프로젝트를 진행하면서 크게 아쉬웠던 점을 꼽으라면 두가지가 있었습니다. 하나는 권한 분리를 제대로 하지 못해 관리자만의 기능을 웹으로 구현하지 못하고 직접 서버상에서 작업해줘야 한다 것과 OSIV(Open Session In View)에 기능으로 인한 지연로딩 오류 였습니다. 관리자 기능의 웹 구현은 현재 만드는 프로젝트의 문제점이나 부족한 점을 파악하고 차기버전 개발 시 해당 내용을 토대로 재개발 예정이며 OSIV로 인한 문제는 JPA의 영속과 준영속에 대한 개념의 이해로 해결이 가능했습니다.









