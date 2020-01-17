$(document).ready(function ()
{
  //console.log($('#lang-words').text());
  //console.log($('#lang-status').text());
  var orange = '#c96c21';
  var yellow = '#ada114';
  var green = '#4db325';
  var cyan = '#26aa94';
  var blue = '#2f67ff';
  var purple = '#b20dff';

  var black = '#404040';

  var statusdict = {
    'Abandoned': black,
    'New': orange,
    'Progressing': yellow,
    'Functional': cyan,
    'Complete': blue,
    'On hold': black,
  }

  var wordscol = orange;
  var wordsval = parseInt($('#lang-words').text().split(' ')[0]);
  if (wordsval >= 5000){wordscol = purple;}
  else if (wordsval >= 2000){wordscol = blue;}
  else if (wordsval >= 1000){wordscol = cyan;}
  else if (wordsval >= 500){wordscol = green;}
  else if (wordsval >= 200){wordscol = yellow;}

  var statuscol = statusdict[$('#lang-status').text()];
  $('#lang-words').css('background-color', wordscol);
  $('#lang-status').css('background-color', statuscol);
});