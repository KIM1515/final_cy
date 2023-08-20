
/**
 * employee.js (관리자 사원 등록)
 */

	//전역변수 선언
	var contextPath = "/gw";

 	$(function() {
		 $('#imageUpload').change(function(){
			 file = $('#imageUpload').prop("files")[0];
	            imageURL = URL.createObjectURL(file);
	            $('#imagePriview img').attr('src', imageURL);
	            $('#imagePriview').slideDown(); 
		});
		 
		//등록(또는 수정) 버튼 클릭시 유효성검사
		$("#empWrite").click(function() {
			var jumin1=$('#jumin1').val();
			var jumin2=$('#jumin2').val();
			
			var jumin="";
			if(jumin1!=="" && jumin2!==""){
				jumin= jumin1 + "-" +jumin2;
			}
			$('#jumin').attr('value', jumin);
			
			var extensionNo1 = $('#extensionNo1').val();
	        var extensionNo2 = $('#extensionNo2').val();
	         
	        var extensionNo="";
	        if (extensionNo1 !=="" && extensionNo2 !== "") {
	            extensionNo= extensionNo1 + "-" + extensionNo2;
	        }
	        $('#extensionNo').attr('value', extensionNo);
			
			var postcode=$('#sample4_postcode').val();
			var roadaddress=$('#sample4_roadAddress').val();
			
			var address="";
			if(postcode!=="" && roadaddress!==""){
				address="("+postcode+")"+roadaddress;
			}
			$('#address').attr('value',address);
			
			var tel1=$('#tel1').val();
			var tel2=$('#tel2').val();
			var tel3=$('#tel3').val();
			
			var tel="";
			if(tel1!=="" && tel2!=="" && tel3!==""){
				tel=tel1+"-"+tel2+"-"+tel3;
			}
			$('#tel').attr('value',tel);
			
			var email1=$('#email1').val();
			var email2=$('#email2').val();
			var email3=$('#email3').val();
			
			var email="";
			if(email1!==""){
				if(email2==="etc"){
					if(email3!==""){
					email=email1+"@"+email3;
					}
				}else{
					email=email1+"@"+email2;
				}	
			}
			$('#email').attr('value',email);
			
			if ($('#name').val().length < 1) {
				alert("사원이름을 입력하세요");
				$('#name').focus();				
				return false;
			}
			
			if ($('#ename').val().length < 1) {
				alert("사원영문이름을 입력하세요");
				$('#ename').focus();				
				return false;
			}
			
			if ($('#jumin').val().length < 1) {
				alert("주민번호를 입력하세요");
				$('#jumin1').focus();				
				return false;
			}
			
			if ($('#pwd').val().length < 1) {
				alert("비밀번호를 입력하세요");
				$('#pwd').focus();
				return false;
			}
			
			if ($('#extensionNo').val().length < 1) {
				alert("내선번호를 입력하세요");
				$('#extensionNo1').focus();
				return false;
			}
			
			if ($('#tel').val().length < 1) {
				alert("전화번호를 입력하세요");
				$('#tel1').focus();
				return false;
			}
			
			if ($('#email').val().length < 1) {
				alert("이메일은 필수 입력 사항입니다.");
				$('#email1').focus();
				return false;
			}
			
			if ($('#sample4_roadAddress').val().length < 1) {
				alert("주소는 필수 입력사항입니다.");
				$('#btnsearchAddress').focus();
				return false;
			}
			
			if ($('#sample4_detailAddress').val().length < 1) {
				alert("상세주소는 필수 입력사항입니다.");
				$('#btnsearchAddress').focus();
				return false;
			}
		
			if (!validate_num($("#extensionNo1").val())
					|| !validate_num($("#extensionNo2").val())) {
				alert("내선번호는 숫자만 가능합니다");
				$("#extensionNo1").focus();
				return false;
			}
			
			if (!validate_num($("#tel1").val())
					||!validate_num($("#tel2").val())
					|| !validate_num($("#tel3").val())) {
				alert("전화번호는 숫자만 가능합니다");
				$("#tel1").focus();
				return false;
			}
			
			if (!validate_num($("#jumin1").val())
					|| !validate_num($("#jumin2").val())) {
				alert("주민번호는 숫자만 가능합니다");
				$("#jumin1").focus();
				return false;
			}
			if ($("#jumin1").val().length!=6
				|| $("#jumin2").val().length!=7) {
				alert("주민번호의 형식이 올바르지 않습니다.");
				$("#jumin1").focus();
				return false;
			}
		});
		
		//직접입력을 선택하면 email3 텍스트 상자가 보이게
		$("#email2").change(function() {
			if ($("#email2").val() == "etc") {
				$("#email3").val("");
				$("#email3").css("visibility", "visible");
				$("#email3").focus();
			} else {
				$("#email3").css("visibility", "hidden");
			}
		});
	});
	
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	
	       var roadAddr = data.roadAddress; // 도로명 주소 변수
	       var extraRoadAddr = ''; // 참고 항목 변수
	
	       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	           extraRoadAddr += data.bname;
	       }
	       if(data.buildingName !== '' && data.apartment === 'Y'){
	          extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	       }
	     
	       document.getElementById('sample4_postcode').value = data.zonecode;
	       document.getElementById("sample4_roadAddress").value = roadAddr;
	       }
	    }).open();
	}
	
	function validate_num(num) {
		var pattern = new RegExp(/^[0-9]*$/g);
		return pattern.test(num); //정규식과 일치하면 true
		/* 정규식 /^[0-9]*$/g
		0 에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미 (^는 시작, $는 끝을 의미)
		닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복 */
	}
