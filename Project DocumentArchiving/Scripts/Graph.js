
            var v = new Array(10);
            for (var i = 0; i < 2; i++) {
                v[i] = "n" + i;
            }
            $(function () { // on dom ready
                // photos from flickr with creative commons license

                var cy = cytoscape({
                    container: document.getElementById('cy'),


                    boxSelectionEnabled: false,
                    autounselectify: true,

                    style: cytoscape.stylesheet()
    .selector('node')
      .css({
          'content': 'data(id)',
          'height': 60,
          'width': 120,
          'background-fit': 'cover',
          'text-valign': 'center',
          'border-color': '#000',
          'border-width': 3,
          'border-opacity': 0.5,
          'shape': 'rectangle'
      })
    .selector('.eater')
      .css({
          'border-width': 9
      })
    .selector('edge')
      .css({
          'width': 6,
          'target-arrow-shape': 'triangle',
          'line-color': '#aaaaaa',
          'target-arrow-color': '#ffaaaa'
      }),
                    //      .selector('#n0').css({ 'border-width': 15, 'border-color': 'Green' }),

                    /*.selector('#bird')
                    .css({
                    'background-image': 'https://farm8.staticflickr.com/7272/7633179468_3e19e45a0c_b.jpg'
                    })
                    .selector('#cat')
                    .css({
                    'background-image': 'https://farm2.staticflickr.com/1261/1413379559_412a540d29_b.jpg'
                    })
                    .selector('#ladybug')
                    .css({
                    'background-image': 'https://farm4.staticflickr.com/3063/2751740612_af11fb090b_b.jpg'
                    })
                    .selector('#aphid')
                    .css({
                    'background-image': 'https://farm9.staticflickr.com/8316/8003798443_32d01257c8_b.jpg'
                    })
                    .selector('#rose')
                    .css({
                    'background-image': 'https://farm6.staticflickr.com/5109/5817854163_eaccd688f5_b.jpg'
                    })
                    .selector('#grasshopper')
                    .css({
                    'background-image': 'https://farm7.staticflickr.com/6098/6224655456_f4c3c98589_b.jpg'
                    })
                    .selector('#plant')
                    .css({
                    'background-image': 'https://farm1.staticflickr.com/231/524893064_f49a4d1d10_z.jpg'
                    })
                    .selector('#wheat')
                    .css({
                    'background-image': 'https://farm3.staticflickr.com/2660/3715569167_7e978e8319_b.jpg'
                    }),*/

                    layout: {
                        name: 'breadthfirst',
                        directed: true,
                        padding: 5

                    },
                    zoomingEnabled: false

                }); // cy init
                var eles = cy.add([
                  { group: "nodes", data: { id: v[0] }, position: { x: 100, y: 300} },
                  { group: "nodes", data: { id: v[1] }, position: { x: 300, y: 200} },
                  { group: "edges", data: { id: "e1", source: v[0], target: v[1]} }
                ]);
                cy.on('click', 'node', function () {
                    alert('Hi ' + this.data('id'));
                    document.getElementById("Hidden1").value += 5;
                });


            });          // on dom ready
            // cy.style().selector('#n0').css({'border-color' : 'Orange'});
