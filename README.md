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

DTO에서 가져온 쿼리 결과물을 가져와 JSP 페이지에 출력
```
```
orderDAO.java 의 일부
orderHistory.jsp 페이지에 필요한 데이터들을 DB에서 가져옴

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
addCartPRO.JSP
장바구니에 추가할 데이터들을 가져와 쿼리를 실행함

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

```
장바구니에 추가할때 실행되는 cartDao.java 로직

   public int cartUpdate(int productN, String id, int amount) {
      int result = 0;
      cartDTO dto = new cartDTO();

      try {
         this.conn = OracleConnection.getConnection();
         String sql = "select * from products where productn=?";
         this.pstmt = this.conn.prepareStatement(sql);
         this.pstmt.setInt(1, productN); 
         this.rs = this.pstmt.executeQuery();
         if (this.rs.next()) {
            if (this.rs.getString("promotion").equalsIgnoreCase("y")) { //프로모션 상품일경우
               dto.setprice(this.rs.getInt("promoprice")); //프로모션 가격으로
            } else {
               dto.setprice(this.rs.getInt("price")); //그냥 가격으로
            }

            dto.setproductN(this.rs.getInt("productn"));//상품번호
            dto.setname(this.rs.getString("name")); //상품명
            dto.setimg(this.rs.getString("img"));  //상품이미지
         }

         sql = "select * from user_cart where productn=? and user_id=?";
         this.pstmt = this.conn.prepareStatement(sql);
         this.pstmt.setInt(1, productN);
         this.pstmt.setString(2, id);
         this.rs = this.pstmt.executeQuery();
         if (this.rs.next()) { //장바구니에 값이 있을경우 업데이트
            sql = "update user_cart set amount =?  where productn=? and user_id =?";
            this.pstmt = this.conn.prepareStatement(sql);
            this.pstmt.setInt(1, this.rs.getInt("amount") + amount);
            this.pstmt.setInt(2, productN);
            this.pstmt.setString(3, id);
            result = this.pstmt.executeUpdate();
         } else { //장바구니에 값이 없을경우 데이터 추가
            sql = "insert into user_cart values(?,?,?,?,?,?)";
            this.pstmt = this.conn.prepareStatement(sql);
            this.pstmt.setInt(1, productN);
            this.pstmt.setString(2, id);
            this.pstmt.setInt(3, dto.getprice());
            this.pstmt.setString(4, dto.getname());
            this.pstmt.setString(5, dto.getimg());
            this.pstmt.setInt(6, amount);
            result = this.pstmt.executeUpdate();
         }
	 
```

```
cart.jsp의 로그인 확인 로직
장바구니에 들어가려면 로그인 된 회원의 정보가 필요하므로
로그인이 되지 않은상태로 장바구니 페이지에 들어갔을 경우 로그인 체크 로직을 실행함 
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
```
 
### 진행하면서 아쉬웠던 점

팀단위로 역할을 나눠 진행하는 첫 웹 개발 프로젝트였기 때문에 미숙한점이 많았다.<br>
아무래도 기능을 나눠서 구현하다보니 다른 페이지와 연동되는것도 생각하며 개발해야 했었고<br>
카카오맵 API로 주소를 불러오거나, 주문완료시 이메일을 가게하는 등 여러 API를 추가하여 완성도를 높이고 싶었는데 그러지 못한게 아쉬웠다.<br>
주문페이지에서 카카오맵 API로 지도를 불러오긴 했지만 실제 서비스에선 지도를 불러와 위치를 설정하는것 보단 주소 검색 기능을 넣는게 더 실용성있고 간결한 코드가 되지 않았을까 생각이 들었다.<br>
 










