<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutBox.aspx.cs" Inherits="OutBox" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
        <script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
        <script type="text/javascript"  src="Scripts/cytoscape.js"></script>
<style type="text/css">
body { 
  font: 14px helvetica neue, helvetica, arial, sans-serif;
}

#cy {
  height: 100%;
  width: 100%;
  position: absolute;
  left: 0%;
  top: 0%;
}

#eat {
  position: absolute;
  left: 1em;
  top: 1em;
  font-size: 1em;
  z-index: -1;
  color: #c88;
  
}
</style>

        
        <script type="text/javascript">
            var count = parent.document.getElementById("t0").value;

            var styleNode = new Array(count + 1);
            var notes = new Array(count + 1);
            var n = new Array(count + 1);
            for (i = 1; i <= count; i++) {
                n[i] = parent.document.getElementById("t" + i).value;
            }
            for (i = 1; i <= count; i++) {
                styleNode[i] = parent.document.getElementById("a" + i).value;
                console.log(styleNode[i]);
            }

            for (i = 1; i <= count; i++) {
                notes[i] = parent.document.getElementById("note" + i).value;
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
          'height': 70,
          'width': 150,
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

                    layout: {
                        name: 'breadthfirst',
                        directed: true,
                        padding: 10

                    },
                    zoomingEnabled: false

                }); // cy init

                var e = new Array(count);   // the edges equals nodes-1.
                for (i = 1; i < count; i++) {
                    e[i] = "e" + i;
                }
                yAxis = -30; xAxis = 100; LToR = -200; opposite = false;

                for (i = 1; i <= count; i++) {
                    if ((i - 1) % 4 == 0) {
                        yAxis += 100;
                        LToR = -LToR; // to change the direction after 4 moves.
                        opposite = true;
                    }
                    if (!opposite) { // to draw below last node directly.
                        xAxis += LToR;
                    }
                    opposite = false;

                    console.log(xAxis, yAxis);

                    var eles = cy.add([
                      { group: "nodes", data: { id: n[i] }, position: { x: xAxis, y: yAxis} }
                    ]);
                }

                for (i = 1; i < count; i++) { // drawing edges.
                    var edges = cy.add([
                    { group: "edges", data: { id: "e" + i, source: n[i], target: n[i + 1]} }
                    ]);
                }

                cy.on('click', 'node', function () {

                    for (var i = 1; i <= count; i++) {
                        if (this.data('id') == n[i]) { // way to know the ith of selected node.
                            var textArea1 = parent.document.getElementById("TextArea1");
                            console.log(textArea1.value);
                            textArea1.value = notes[i];

                        }
                    }

                });
                for (i = 1; i <= count; i++) {

                    switch (styleNode[i]) {
                        case '1':
                            cy.style()
                                  .selector('#' + n[i])
                                    .style({
                                        'border-color': 'Orange',
                                        'border-width': 15

                                    }).update(); // update the elements in the graph with the new style
                            break;
                        case '2':
                            cy.style()
                                  .selector('#' + n[i])
                                    .style({
                                        'border-color': 'Green',
                                        'border-width': 15

                                    }).update(); // update the elements in the graph with the new style
                            break;

                        case '3':
                            cy.style()
                                  .selector('#' + n[i])
                                    .style({
                                        'border-color': 'Red',
                                        'border-width': 15

                                    }).update(); // update the elements in the graph with the new style
                            break;

                        case '4':
                            cy.style()
                                  .selector('#' + n[i])
                                    .style({
                                        'border-color': 'Pink',
                                        'border-width': 15

                                    }).update(); // update the elements in the graph with the new style
                            break;
                        default:
                            break;
                    }
                }

            });                                                // on dom ready
            // cy.style().selector('#n0').css({'border-color' : 'Orange'});
        </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="cy"></div>
    </form>
    <p>
        &nbsp;</p>
</body>
</html>
