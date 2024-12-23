const express = require('express');
const authRoutes = require('./routes/authRoutes');
const projectRoutes = require('./routes/projectRoutes');
const bodyParser = require('body-parser');
const subttaskRoutes = require('./routes/subtaskListRoutes');
const taskRoutes = require('./routes/taskListRoutes');
const dbRoutes = require('./routes/dbRoutes');
const serviceRoutes = require('./routes/serviceRoutes')
const timesheetRoutes = require('./routes/timesheetRoutes')
const cors = require('cors');
const path = require('path');

const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(bodyParser.json());
app.use(cors())

app.use('/api/auth', authRoutes);
app.use('/api/projects', projectRoutes);
app.use('/api/subtasklist', subttaskRoutes);
app.use('/api/tasks', taskRoutes);
app.use('/api/taskcategories', dbRoutes);
app.use('/api/servicecalls', serviceRoutes);
app.use('/api/timesheet',timesheetRoutes)

// Serve the profile folder as static files
app.use('/profile', express.static(path.join(__dirname, 'profile')));

const PORT = process.env.APP_PORT;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
