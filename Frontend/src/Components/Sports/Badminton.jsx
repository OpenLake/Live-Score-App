
import React, { useState } from 'react'
import Timeline from '../Card/Timeline'
import Button from '@mui/material/Button';
import '../component.css';

export default function Badminton() {
   const [active, setActive]= useState("girls")
  return (
    <div>
      { active ==="boys" &&
        <Button onClick={()=> setActive("girls")} style={{margin:'3px 3px'}} variant="contained">
        GIRLS
        </Button>
      }
      { active ==="girls" &&
        <Button onClick={()=> setActive("boys")} style={{margin:'3px 3px'}} variant="contained">
         BOYS
        </Button>
      }
      {/* <Timeline user={active}/> */}
      <Timeline />
    </div>
  )
}
