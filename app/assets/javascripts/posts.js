document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('p').forEach(function(p) {
    p.addEventListener('mouseover', function(e) {
      e.currentTarget.style.backgroundColor = '#eff';
    });

    p.addEventListener('mouseout', function(e) {
      e.currentTarget.style.backgroundColor = '';
    });
  });

  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
      const p = a.parentNode;
      const div = p.parentNode;
      div.style.display = 'none'  
    })
  })
});
