![image](https://github.com/user-attachments/assets/63f890e5-8051-43ae-89a0-f50fd5cdb963)<h1><p align="center"> 주류 판매 쇼핑몰 Would you(酒) Like? 🍷</p></h1>


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
ORDERHISTORY.JSP 일부

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

```
```
orderDAO.java 의 일부

public ArrayList<orderDTO> getBuyInfo(String id) {
      ArrayList<orderDTO> list = new ArrayList();

      try {
         this.conn = OracleConnection.getConnection();
         String sql = "select * from orderinfo where memberid=? and ordercomplete ='\uc218\ub839\uc644\ub8cc' order by orderdate desc";
         this.pstmt = this.conn.prepareStatement(sql);
         this.pstmt.setString(1, id);
         this.rs = this.pstmt.executeQuery();

         while(this.rs.next()) {
            orderDTO dto = new orderDTO();
            dto.setproductNum(this.rs.getInt("productNum"));
            dto.setmemberID(this.rs.getString("memberid"));
            dto.setreceive(this.rs.getString("receive"));
            dto.setpayment(this.rs.getString("payment"));
            dto.setorderDate(this.rs.getString("orderdate"));
            dto.setordercomplete(this.rs.getString("ordercomplete"));
            dto.setpricesum(this.rs.getInt("pricesum"));
            dto.setordername(this.rs.getString("ordername"));
            dto.setmobilenum(this.rs.getString("mobilenum"));
            dto.setorderamount(this.rs.getInt("orderamount"));
            list.add(dto);
         }

```
![image](https://github.com/user-attachments/assets/b25358c0-0f7b-4088-a9e0-a19b22c993b2)


```
ADDCARTPRO.JSP

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

```

 
### 진행하면서 아쉬웠던 점

팀단위로 역할을 나눠 진행하는 첫 웹 개발 프로젝트였기 때문에 미숙한점이 많았다.<br>
아무래도 기능을 나눠서 구현하다보니 다른 페이지와 연동되는것도 생각하며 개발해야 했었고<br>
카카오맵 API로 주소를 불러오거나, 주문완료시 이메일을 가게하는 등 여러 API를 추가하여
 










