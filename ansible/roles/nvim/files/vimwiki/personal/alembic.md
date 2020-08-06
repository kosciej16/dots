## Changing name
op.alter_column("table", "column", new_column_name="")

## Changing primary key

op.execute("alter table <table> drop constraint _pkey")
op.execute("alter table <table add primary key <column>")
