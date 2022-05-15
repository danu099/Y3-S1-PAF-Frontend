<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">



<style>
.row{
margin-top: 2em;
}
.heading{
margin-top: 0.5em;
}





h1 {
color: black;
box-shadow: #500e0e 0 0 20px 0px;
background-color: #ffd700b8;
padding: 10px;
text-align: center;
}




.button2 {
padding: 11px 115px;
background-color: #0d6efd;
margin-left: 37%;
margin-top: 5%;
color: white;
}



div {
border-radius: 5px;
background-color: #6748481c;
padding: 20px;
}





.button3 {
padding: 11px 104px;
background-color: #4caf50;
margin-left: 8%;
margin-top: 5%;
color: white;
}



a {
color: #ffffff;
text-decoration: underline;
}



</style>

<head>
	<meta charset="UTF-8">
	<title>Title</title>
	
    <script src="assets/js/croppie.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.js"></script>
	
</head>
<body>
	
    <div class="container">
		
<br>
<p></p>

	                    <h1>Unit Management</h1>
	                        <form id="userRegister">
	                            <div>
	                                <label>Account ID</label>
	                                <div>
	                                    <input type="text" id="accountId" class="form-control" name="accountId">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Number of Units</label>
	                                <div>
	                                    <input type="number" id="numberOfUnits" class="form-control" name="numberOfUnits">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>From date</label>
	                                <div>
	                                    <input type="date" id="fromDate" class="form-control" name="fromDate">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>To date</label>
	                                <div>
	                                    <input type="date" id="toDate" class="form-control" name="toDate">
	                                </div>
	                            </div>
	                            
	                            <div>
	                                <label>Bill Amount</label>
	                                <div>
	                                    <input type="text" id="billAmount" class="form-control" name="billAmount">
	                                </div>
	                            </div>
	                            
	                            <div>
	                               <button class="button3" type="submit" class="btn btn-success">
										Submit
										</button >
										<button class="button2" >
										<a href="edit_n_delete.jsp" >
										Unit Management List
										</a>
										</button>
	                            </div>
	                    	</form>
	                    </div>

</body>
</html>
<script>

$(document).ready(function () {

    $("#userRegister").validate({
        rules: {
        	accountId: "required",
        	numberOfUnits: "required",
        	fromDate: "required",
        	toDate: "required",
        	billAmount: "required"
        },
        messages: {
        	accountId: "required",
        	numberOfUnits: "required",
        	fromDate: "required",
        	toDate: "required",
        	billAmount: "required"
        },
        submitHandler: function () {
        	var fromData = JSON.stringify({
                "account_number" : $('#accountId').val(),
                "units" : $('#numberOfUnits').val(),
                "f_date" : $('#fromDate').val(),
                "t_date" : $('#toDate').val(),
                "amount" : $('#billAmount').val()             
            });
        	
        	console.log(fromData);

            $.ajax({
                type: "POST",
                url: 'rest_api/unit',
                dataType : 'json',
				contentType : 'application/json',
				data: fromData,
                success: function(data){
                	console.log(data);
                	if(data['success']=="Done"){
                		alert("Added Successfull!");
                        $("#userRegister")[0].reset();
					}else{
						alert("Unsuccessfull!");
					}
                },
                failure: function(errMsg) {
                	alert("Connection Error!");
                }
            });
        }
    });

    $("#userRegister").submit(function(e) {
        e.preventDefault();
    });

});

</script>