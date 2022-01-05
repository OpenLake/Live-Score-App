
import React, { useState } from 'react'
import Timeline from '../../Card/Timeline'
import Button from '@mui/material/Button';
import '../../component.css';

export default function Badminton() {
   const [active, setActive]= useState("female")
  return (
    <div>
      { active ==="male" &&
        <Button onClick={()=> setActive("female")} style={{margin:'3px 3px'}} variant="contained">
        GIRLS
        </Button>
      }
      { active ==="female" &&
        <Button onClick={()=> setActive("male")} style={{margin:'3px 3px'}} variant="contained">
         BOYS
        </Button>
      }
      <Timeline activeuser={active}/>
      {/* <Timeline /> */}
    </div>
  )
}