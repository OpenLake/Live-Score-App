import  React ,{useContext} from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import MenuItem from '@mui/material/MenuItem';
import { Link } from 'react-router-dom';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import { UserContext } from '../UserContext';

const Navbar = () => {
	const [anchorElNav, setAnchorElNav] = React.useState(null);
	const {admin,setAdmin}=useContext(UserContext)

	const handleOpenNavMenu = event => {
		setAnchorElNav(event.currentTarget);
	};

	const handleCloseNavMenu = () => {
		setAnchorElNav(null);
	};

	const logout=()=>{
		setAdmin(false)
		localStorage.setItem('islogin','')

	}

	return (
		<AppBar position="static">
			<Container maxWidth="xl">
				<Toolbar disableGutters>
					<Link to="/" style={{ textDecoration: 'none', color: 'white' }}>
						<Typography
							variant="h6"
							noWrap
							component="div"
							sx={{ mr: 2, display: { xs: 'none', md: 'flex' } }}
						>
							PRAYATNA
						</Typography>
					</Link>

					<Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}>
						<IconButton
							size="large"
							aria-label="account of current user"
							aria-controls="menu-appbar"
							aria-haspopup="true"
							onClick={handleOpenNavMenu}
							color="inherit"
						>
							<MenuIcon />
						</IconButton>
						<Menu
							id="menu-appbar"
							anchorEl={anchorElNav}
							anchorOrigin={{
								vertical: 'bottom',
								horizontal: 'left',
							}}
							keepMounted
							transformOrigin={{
								vertical: 'top',
								horizontal: 'left',
							}}
							open={Boolean(anchorElNav)}
							onClose={handleCloseNavMenu}
							sx={{
								display: { xs: 'block', md: 'none' },
							}}
						>
							<MenuItem onClick={handleCloseNavMenu}>
								<Link
									to="/badminton"
									style={{ textDecoration: 'none', color: 'black' }}
								>
									<Typography textAlign="center">BADMINTON</Typography>
								</Link>
							</MenuItem>
							<MenuItem onClick={handleCloseNavMenu}>
							<Link
									to="/tabletennis"
									style={{ textDecoration: 'none', color: 'black' }}
								>
									<Typography textAlign="center">TABLE TENNIS</Typography>
								</Link>
							</MenuItem>
						</Menu>
					</Box>

					<Typography
						variant="h6"
						noWrap
						component="div"
						sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}
					>
						PRAYATNA
					</Typography>

					<Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' } }}>
						<Link to="/badminton" style={{ textDecoration: 'none' }}>
							<Button sx={{ my: 2, color: 'white', display: 'block' }}>
								BADMINTON
							</Button>
						</Link>
						<Link to="/tabletennis" style={{ textDecoration: 'none' }}>
							<Button sx={{ my: 2, color: 'white', display: 'block' }}>
								TABLE TENNIS
							</Button>
						</Link>
					</Box>

					<Box sx={{ flexGrow: 0 }}>
					{admin ?
						<Link to="/" style={{ textDecoration: 'none' }}>
						<Button sx={{ p: 0 }}  style={{ color: 'white' }} onClick={()=> logout()}> 
							Logout
						</Button>
					</Link>:
					<Link to="/login" style={{ textDecoration: 'none' }}>
						<Button sx={{ p: 0 }}  style={{ color: 'white' }}> 
							<AccountCircleIcon fontSize="large" style={{ color: 'white' }} />
						</Button>
					</Link>
					}
					</Box>
				</Toolbar>
			</Container>
		</AppBar>
	);
};
export default Navbar;
