package com.simpf.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.simpf.domain.CartVO;
import com.simpf.domain.CartVOList;
import com.simpf.dto.CartDTO;
import com.simpf.mapper.CartMapper;

import lombok.Setter;

@Service
public class CartServiceImpl implements CartService {

	@Setter(onMethod_ = @Autowired)
	private CartMapper mapper;
	
	@Override
	public void addCart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		mapper.addCart(vo);
	}

	@Override
	public List<CartVOList> cartList(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.cartList(ui_id);
	}

	@Override
	public void deleteCart(long sc_code) throws Exception {
		// TODO Auto-generated method stub
		mapper.deleteCart(sc_code);
	}

	@Override
	public void allDeleteCart(String ui_id) throws Exception {
		// TODO Auto-generated method stub
		mapper.allDeleteCart(ui_id);
	}

	@Override
	public void updateCart(long sc_code, int sc_amount) throws Exception {
		// TODO Auto-generated method stub
		mapper.updateCart(sc_code, sc_amount);
	}

	@Override
	public void checkedDeleteCart(List<Long> checkArr) throws Exception {
		// TODO Auto-generated method stub
		mapper.checkedDeleteCart(checkArr);
	}

	@Override
	public List<CartVOList> checkedOrderCart(String ui_id, List<Long> item) throws Exception {
		// 사용자 - 선택상품 구매 이동
		return mapper.checkedOrderCart(ui_id, item);
	}
	
	@Override
	public List<CartDTO> cart_money() throws Exception {
		return mapper.cart_money();
	}

	@Override
    public JSONObject getChartData() throws Exception {//제이슨 오브젝트를 리턴하는 것 JSON구조를 나타내는 클래스.
        // getChartData메소드를 호출하면
        //db에서 리스트 받아오고, 받아온걸로 json형식으로 만들어서 리턴을 해주게 된다.
		List<CartDTO> items = mapper.cart_money();
		/*
		List<CartDTO> items = new ArrayList<CartDTO>();
        
        Random rand = new Random();
        
        for(int i=1;i <= 5; i++) {
        	CartDTO cart = new CartDTO();
        	int price = rand.nextInt(10000 - 1000 + 1) + 1000; // 1000 ~ 10000
        	cart.setAmount(price);
        	cart.setPd_name("전자제품" + i);
        	
        	items.add(cart);
        }
        */
        
        
        //json의 칼럼 객체
        JSONObject col1 = new JSONObject();
        col1.put("label","상품명"); // {"label" : "상품명"}  col1에 자료를 저장 ("필드이름","자료형")
        col1.put("type", "string"); // {"type" : "string"}
        
        JSONObject col2 = new JSONObject();
        col2.put("label", "금액"); // {"label" : "금액"}
        col2.put("type", "number"); // {"type" : "number"}
        
        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용.ArrayList 클래스 상속
        //테이블행에 컬럼 추가
        JSONArray title = new JSONArray(); // [  ]
        title.add(col1); // [ {"label" : "상품명"}, {"type" : "string"},
        title.add(col2); //   {"label" : "금액"}, {"type" : "number"} ]
        
        //json 객체에 타이틀행 추가
        //리턴할 json 객체. HashMap 클래스 상속
        JSONObject data = new JSONObject(); //{}
        data.put("cols", title);//제이슨을 넘김
        // 이런형식으로 추가가된다. 
        // {"cols" : [{"label" : "상품명","type":"string"}, {"label" : "금액", "type" : "number"}]}
        
        JSONArray body = new JSONArray(); //json 배열을 사용하기 위해 객체를 생성
        for (CartDTO dto : items) { //items에 저장된 값을 dto로 반복문을 돌려서 하나씩 저장한다.
            
            JSONObject name = new JSONObject(); //json오브젝트 객체를 생성
            name.put("v", dto.getPd_name()); //name변수에 dto에 저장된 상품의 이름을 v라고 저장한다.
            
            JSONObject money = new JSONObject(); //json오브젝트 객체를 생성
            money.put("v", dto.getAmount()); //name변수에 dto에 저장된 금액을 v라고 저장한다.
            
            // [{"v" : "전자제품1"}, {"v" : 15000}]
            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
            row.add(name); //name을 row에 저장 (테이블의 행)
            row.add(money); //name을 row에 저장 (테이블의 행)
            
            // {"c" : [{"v" : "전자제품1"}, {"v" : 15000}]}
            JSONObject cell = new JSONObject(); 
            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
            
            
            // [{"c" : [{"v" : "전자제품1"}, {"v" : 15000}]}, {"c" : [{"v" : "전자제품2"}, {"v" : 25000}]}, ... ]
            body.add(cell); //레코드 1개 추가
                
        }
        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 한다.
        
        /*
         { "cols" : [{"label" : "상품명","type":"string"}, {"label" : "금액", "type" : "number"}],
           "rows" : [{"c" : [{"v" : "전자제품1"}, {"v" : 15000}]}, {"c" : [{"v" : "전자제품2"}, {"v" : 25000}]}, ... ]}
         */
        return data; //이 데이터가 넘어가면 json형식으로 넘어가게되서 json이 만들어지게 된다.
    }

		
}
