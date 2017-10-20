SELECT
  row_number() OVER () AS id,
  stops.name AS stop_name,
  stations.name AS station_name,
  routes.name AS route_name,
  directions.name AS direction_name,
  stops.external_id AS stop_external_id,
  stations.external_id AS station_external_id,
  routes.external_id AS route_external_id,
  directions.external_id AS direction_external_id,
  stops.id AS stop_id,
  stations.id AS station_id,
  routes.id AS route_id,
  directions.id AS direction_id,
  stations.diction As station_diction,
  stops.diction AS stop_diction,
  routes.diction AS route_diction,
  directions.diction AS direction_diction
FROM
 stops
LEFT JOIN stations
  ON stations.id = stops.station_id
INNER JOIN directions
  ON directions.id = stations.direction_id
INNER JOIN routes
  ON routes.id = stations.route_id
WHERE
  stops.fake = false
  AND stations.fake = false
  AND routes.fake = false
  AND directions.fake = false;

