// console.log('Hello World from Webpacker')



if (document.querySelector('.search_page')){
    let bar_id = document.querySelector('.bar_information').getAttribute("data-id")
    let bar_labels = JSON.parse(document.querySelector('.bar_information').getAttribute("data-labels"))
    let bar_data = JSON.parse(document.querySelector('.bar_information').getAttribute("data-data"))
    let bar_labeltext = document.querySelector('.bar_information').getAttribute("data-labeltext")
    let bar_titletext = document.querySelector('.bar_information').getAttribute("data-titletext")
    barChart(bar_id, bar_labels, bar_data, bar_labeltext, bar_titletext);

    let pie_id = document.querySelector('.pie_information').getAttribute("data-id")
    let pie_labels = JSON.parse(document.querySelector('.pie_information').getAttribute("data-labels"))
    let pie_data = JSON.parse(document.querySelector('.pie_information').getAttribute("data-data"))
    let pie_labeltext = document.querySelector('.pie_information').getAttribute("data-labeltext")
    let pie_titletext = document.querySelector('.pie_information').getAttribute("data-titletext")
    pieChart(pie_id, pie_labels, pie_data, pie_labeltext, pie_titletext);

}


//// chart creating function ////

Chart.defaults.bar.scales.yAxes[0].categorySpacing = 0;
Chart.defaults.global.defaultFontSize = 16;

// barChart
function barChart(id, labels, data, labelText, titleText) {
    // console.log('bar Chart function...')
    new Chart(document.getElementById(id), {
        type: 'horizontalBar',
        data: {
            labels: labels,
            datasets: [{
                label: labelText,
                backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
                data: data
            }]
        },
        options: {
            legend: {
                display: false
            },
            title: {
                display: true,
                text: titleText
            },
            scales: {
                yAxes: [{
                    barPercentage: 1,
                }]
            }
        }
    });
}

// pieChart
function pieChart(id, labels, data, labelText, titleText) {
    new Chart(document.getElementById(id), {
        type: 'pie',
        data: {
          labels: labels,
          datasets: [{
            label: labelText,
            backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
            data: data
          }]
        },
        options: {
          title: {
            display: true,
            text: titleText
          }
        }
      });
}

// show chart

function show(id){
    // console.log(id)
    let bar_id = document.querySelector(`.${id}`).getAttribute("data-id")
    let bar_labels = JSON.parse(document.querySelector(`.${id}`).getAttribute("data-labels"))
    let bar_data = JSON.parse(document.querySelector(`.${id}`).getAttribute("data-data"))
    let bar_labeltext = document.querySelector(`.${id}`).getAttribute("data-labeltext")
    let bar_titletext = document.querySelector(`.${id}`).getAttribute("data-titletext")

    barChart(bar_id, bar_labels, bar_data, bar_labeltext, bar_titletext);
};



if (document.querySelector('.home_page')){

    // VALIDATE USER SEARCH TERM
    let form = document.querySelector('.form')
    form.onsubmit = function validateForm() {
        // console.log('validating....')
        let x = document.forms['new_search']['search_keyword'].value
        if (x.trim() == "") {
            alert("Must be filled out");
            return false;
        }

        let search_input = document.querySelector('#search_keyword');
        let search_message = document.querySelector('#search-message');
        search_input.style.display = 'none';
        search_message.style.display = 'block';
    }



    show('show_popular');    
    let tabs = document.querySelectorAll('.tab');
    let chart_section = document.querySelector('.chart-section');
    
    tabs.forEach((tab) => {
        tab.addEventListener('click', function () {
            tabs[0].scrollIntoView();
            tabs.forEach((tab) => {
                tab.setAttribute('data-state', 'non-active');
            });
            tab.setAttribute('data-state', 'active');
            content = `<canvas id="chart" width="400" height="400"></canvas>`;
            chart_section.innerHTML = content;
            show(this.id);
        });
    });

}



// footer

document.addEventListener('scroll', function () {
    scrollShow('#footer', 'animate');
  });
  function scrollShow(selector, action) {
    var selector = selector;
    var action = action;
    var inVisible = window.innerHeight > Math.abs(document.querySelector(selector).getBoundingClientRect().top);
    if (inVisible) {
      document.querySelector(selector).classList.add(action);
    } else {
      setTimeout(() => {
        document.querySelector(selector).classList.remove(action);
      }, 50);
      inVisible = false;
    }
  }

