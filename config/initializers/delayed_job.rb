# Don't delay jobs in development or test environments.
#Delayed::Worker.delay_jobs = (!Rails.env.development? && !Rails.env.test?)
Delayed::Worker.delay_jobs = !Rails.env.test?