import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';

import Typography from '@mui/material/Typography';
import { Button, CardActionArea, CardActions } from '@mui/material';


export default function MultiActionAreaCard({prop}) {
  let toshow= prop.winner === "Match pending";
  
  var newDate = new Date(prop.date).toLocaleDateString();
// var date = d.getDate();
// var month = d.getMonth() + 1; // Since getMonth() returns month from 0-11 not 1-12
// var year = d.getFullYear();
// var newDate = date + "/" + month + "/" + year;

  return (
    <Card style={{boxShadow: '0px 1px 10px 1px black'}} sx={{ maxWidth: 500 }}>
      <CardActionArea>

        <div style={{height:'50px',
        background: 'linear-gradient(to left,#a5f3fc,#06b6d4)' }}>
            
                <Typography variant="h5" style={{textAlign:'center',
                paddingTop:'5px',
                
                }}>
            {newDate}</Typography>
        </div>
      
        <CardContent>
          <Typography gutterBottom variant="h6" component="div">
           {prop.title}
          </Typography>
          <Typography variant="body2" color="text.secondary">
            <span>Winner:</span>  {prop.winner}
          </Typography>
        </CardContent>
      </CardActionArea>
      <CardActions>
        <Button href={`/badmintonscore/${prop._id}`} size="small" color="primary" disabled={toshow} >
          View Score
        </Button>
      </CardActions>
    </Card>
  );
}