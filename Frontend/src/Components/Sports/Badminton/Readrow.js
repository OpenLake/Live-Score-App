import React from 'react';
import {TableCell, TableRow, makeStyles } from '@material-ui/core'
import { Button} from '@mui/material';

const useStyles = makeStyles({
    row: {
        '& > *': {
            fontSize: 18
        }
    }
})

function Readrow({user}){
    var currentDate=new Date().toLocaleDateString('en-GB');
    var matchDate = new Date(user.date).toLocaleDateString('en-GB');
   const showedit= matchDate===currentDate;
//    const showedit=true
   console.log(user.date)
    console.log(matchDate)
    console.log(currentDate)
    console.log(showedit)
    const classes = useStyles();
    console.log(user)
    return(
        <>
            <TableRow className={classes.row}>
                        <TableCell>Set1</TableCell> 
                        <TableCell>{user.set1[0]}</TableCell>
                        <TableCell>{user.set1[1]}</TableCell>
                        {showedit && <TableCell>
                            <Button href={`/editscore/${user._id}/set1`} color="primary" variant="contained" style={{marginRight:10}} >Edit</Button> 
                        </TableCell>
                        }
                    </TableRow>
                    <TableRow className={classes.row}>
                        <TableCell>Set2</TableCell>
                        <TableCell>{user.set2[0]}</TableCell>
                        <TableCell>{user.set2[1]}</TableCell>
                       {showedit && <TableCell>
                        <Button href={`/editscore/${user._id}/set2`} color="primary" variant="contained" style={{marginRight:10}} >Edit</Button> 
                        </TableCell>
                       }
                    </TableRow>
                    <TableRow className={classes.row}>
                        <TableCell>Set3</TableCell> 
                        <TableCell>{user.set3[0]}</TableCell>
                        <TableCell>{user.set3[1]}</TableCell>
                        {showedit && <TableCell>
                        <Button href={`/editscore/${user._id}/set3`} color="primary" variant="contained" style={{marginRight:10}} >Edit</Button> 
                        </TableCell>
                        }
                    </TableRow>
        </>
    )
}

export default Readrow;
