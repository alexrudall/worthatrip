function checkDistance(event) {
  event.preventDefault();
  document.getElementById('results').classList.remove('invisible');
  document.getElementById('output').innerHTML = 'Loading...';
  document.getElementById('from').classList.remove('border-red-500');
  document.getElementById('to').classList.remove('border-red-500');
  document.getElementById('from-error').classList.add('invisible');
  document.getElementById('to-error').classList.add('invisible');

  var from = event.currentTarget[0].value
  var max = event.currentTarget[1].value
  var to = event.currentTarget[2].value
  var url = encodeURI(`api/v1/handler?from=${from}&to=${to}`)

  var request = new XMLHttpRequest();
  request.open('GET', url, true);
  request.onload = function() {
    if (this.status == 200) {
      var distance = parseInt(request.responseText);
      document.getElementById('results').classList.remove('invisible');

      if (distance <= max) {
        document.getElementById('output').innerHTML = 'Nice, you deliver to this location!';
      } else {
        document.getElementById('output').innerHTML = "You don't deliver this far!";
      }
    } else {
      document.getElementById('results').classList.add('invisible');

      if (request.responseText.includes('from')) {
        document.getElementById('from').classList.add('border-red-500');
        document.getElementById('from-error').classList.remove('invisible');
        document.getElementById('from-error').innerHTML = request.responseText;
      } else if (request.responseText.includes('to')) {
        document.getElementById('to').classList.add('border-red-500');
        document.getElementById('to-error').classList.remove('invisible');
        document.getElementById('to-error').innerHTML = request.responseText;
      }
    }
  };
  request.send();
}
