SELECT
  row_number() OVER () AS id,
  stops.name AS stop_name,
  routes.name AS route_name,
  directions.name AS direction_name,
  stops.external_id AS stop_external_id,
  routes.external_id AS route_external_id,
  directions.external_id AS direction_external_id,
  stops.id AS stop_id,
  routes.id AS route_id,
  directions.id AS direction_id,
  stops.diction AS stop_diction,
  routes.diction AS route_diction,
  directions.diction AS direction_diction
FROM
  stops
INNER JOIN directions
  ON directions.id = stops.direction_id
INNER JOIN routes
  ON routes.id = stations.route_id;

