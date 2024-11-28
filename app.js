const express = require('express');
const authRoutes = require('./routes/authRoutes');
const projectRoutes = require('./routes/projectRoutes');
const bodyParser = require('body-parser');
const subttaskRoutes = require('./routes/subtaskListRoutes');
const taskRoutes = require('./routes/taskListRoutes');
const dbRoutes = require('./routes/dbRoutes');
const serviceRoutes = require('./routes/serviceRoutes')
const cors = require('cors');


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


const PORT = process.env.APP_PORT;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
