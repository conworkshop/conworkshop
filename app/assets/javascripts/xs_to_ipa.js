$('#xSampaToIPAInput').keyup(function ()
{
  $("#xSampaToIPAOutput").html("...");
  //console.log("succ"); 
  $.ajax(
    {
    type: 'GET',
	xhrFields: { withCredentials: true },
    beforeSend: function(xhr) {xhr.setRequestHeader('Authorization', 'Basic ' + btoa('myuser:mypswd'))},
    url: "/sidebar/xs_to_ipa", 
    data: {xs: $("#xSampaToIPAInput").val()}//, 
    //success: function(d){$("#xSampaToIPAOutput").val(d)}
    }
  ).done(function (d){
	//console.log(d);
	$("#xSampaToIPAOutput").html(d);
  });
});